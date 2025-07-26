-- Author: GamerDesigns/RMC
-- Name: Node Index Resolver
-- Description: Opens a tool window to input an index path, resolves the node in the scenegraph, displays its name, and selects it instantly
-- Icon: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAk1BMVEUAAAD///8BAQFYV1g1NjZqa2sCAgELCwoODg0RERAUFBMxMTBUVFNSUlFPT05nZ2ZkZGNjY2JgYF9cXFtZWVhXV1ZpaWlnZ2dlZWVjY2NhYWFgYGBeXl5cXFxYWFhSUlJRUVFPT09OTk5LS0tAQEA4ODg1NTUtLS0pKSkWFhYSEhIODg4FBQUEBAQDAwMCAgL///8DsCeDAAAAMXRSTlP///////////////////////////////////////////////////////////////8AH5pOIQAAAAlwSFlzAAALEwAACxMBAJqcGAAAALJJREFUGJVFz00vA2EAxPHfPp6s1tLEpkURFY2SEPb7fwqvcaiogzhQEaJByXJ4NOYy/8xhJpNVwJmjBCHZqK5vE0UuvlfzrUu98/C115RVTvyrElhz7HCnNy9XEvl0WsSW5clQRuDZwS4UC57IoL8Ebl5ns4+p8QfmqvxFaINibKMflKX3CbxdWeyIRGHY6Gpe59MWkQe1jxGm7lcEBtY7QrDdtU+W3t6Nbabmv0A9+/0LRgwpOB0x+KgAAAAASUVORK5CYII=
-- AlwaysLoaded: no
-- Hide: no

IndexPath = {}

function IndexPath.resolveNodeByIndexPath(indexPath)
    local node = getRootNode()

    local parts = {}
    for part in string.gmatch(indexPath, "[^>]+") do
        table.insert(parts, part)
    end

    for _, subPath in ipairs(parts) do
        local indices = {}
        for piece in string.gmatch(subPath, "[^|]+") do
            table.insert(indices, piece)
        end

        for _, indexStr in ipairs(indices) do
            local curIndex = tonumber(indexStr)
            if curIndex == nil then
                print("❌ Invalid index: " .. tostring(indexStr))
                return nil
            end

            local numChildren = getNumOfChildren(node)
            if numChildren <= curIndex then
                print(string.format("❌ Index out of bounds: %d (children: %d)", curIndex, numChildren))
                return nil
            end

            node = getChildAt(node, curIndex)
        end
    end

    return node
end

function IndexPath.show()
    local title = "Node Index Resolver by GamerDesigns/RMC"
    local text = "Enter your index path:"
    local defaultValue = ""

    local windowRowSizer = UIRowLayoutSizer.new()
    local window = UIWindow.new(windowRowSizer, title, false, true)

    local bgSizer = UIRowLayoutSizer.new()
    UIPanel.new(windowRowSizer, bgSizer, -1, -1, 400, -1, BorderDirection.NONE, 0, 1)

    local uiBorderSizer = UIRowLayoutSizer.new()
    local panel = UIPanel.new(bgSizer, uiBorderSizer, -1, -1, -1, -1, BorderDirection.NONE, 0, 1)
    panel:setBackgroundColor(1, 1, 1, 1)

    local rowSizerElements = UIRowLayoutSizer.new()
    UIPanel.new(uiBorderSizer, rowSizerElements, -1, -1, -1, -1, BorderDirection.ALL, 15, 1)

    UILabel.new(rowSizerElements, text, true, TextAlignment.LEFT, VerticalAlignment.TOP, -1, -1, 400, -1, BorderDirection.BOTTOM, 10, 1)

    local textArea = UITextArea.new(rowSizerElements, defaultValue, TextAlignment.LEFT, false, false, -1, -1, -1, -1, -1, 0)
    UILabel.new(rowSizerElements, "Node Name:", false, TextAlignment.LEFT, VerticalAlignment.TOP, -1, -1, 400, -1, BorderDirection.TOP, 5, 1)
    local resultText = UITextArea.new(rowSizerElements, "", TextAlignment.LEFT, false, false, -1, -1, -1, -1, -1, 0)
    UIHorizontalLine.new(bgSizer, -1, -1, -1, -1, BorderDirection.BOTTOM, 0, 0)

    local columnSizerButtons = UIColumnLayoutSizer.new()
    UIPanel.new(bgSizer, columnSizerButtons, -1, -1, 200, -1, BorderDirection.ALL, 10)

    UILabel.new(columnSizerButtons, "", false, TextAlignment.LEFT, VerticalAlignment.TOP, -1, -1, 370, -1, BorderDirection.NONE, 0, 1)

    local wasButtonPressed = false

    local onClickSearch = function()
        wasButtonPressed = true

        local indexPath = textArea:getValue()

        local nodeId = IndexPath.resolveNodeByIndexPath(indexPath)
        if nodeId ~= nil then
            local name = getName(nodeId)
            resultText:setValue(name)

            for i = getNumSelected() - 1, 0, -1 do
                removeSelection(getSelection(i))
            end

            addSelection(nodeId)
            refreshViewport(true)
        else
            resultText:setValue("Not Found")
        end
    end

    UIButton.new(columnSizerButtons, "Search", onClickSearch, nil, -1, -1, 80, 24, BorderDirection.RIGHT, 10, 0)

    local onClose = function()
        if wasButtonPressed then return end
        print("Index Path dialog closed.")
    end
    window:setOnCloseCallback(onClose)


    -- ✅ Optional close callback
    local onClose = function()
        if wasButtonPressed then return end
        print("Index Path dialog closed.")
    end
    window:setOnCloseCallback(onClose)

    UILabel.new(
        rowSizerElements,
        "",
        false,
        TextAlignment.LEFT,
        VerticalAlignment.TOP,
        -1, -1, -1, -1,
        BorderDirection.NONE,
        10, 1    -- 👈 Adjust '10' for more space
    )

    UIHorizontalLine.new(rowSizerElements, -1, -1, -1, -1, BorderDirection.TOP, 0, 0)

    UITextArea.new(
        rowSizerElements,
        "https://www.patreon.com/roughneckmoddingcrew",
        TextAlignment.CENTER,
        false,          -- not bold
        false,          -- single line
        -1, -1, -1, -1,
        BorderDirection.NONE,
        10, 0
    )

    -- Helpful tip
    UILabel.new(
        rowSizerElements,
        "Tip: Highlight anything and press Ctrl+C to copy",
        false,
        TextAlignment.CENTER,
        VerticalAlignment.TOP,
        -1, -1, -1, -1,
        BorderDirection.NONE,
        2, 1
    )

    window:fit()
    window:refresh()
    window:showWindow()

    return window
end

IndexPath.show()
