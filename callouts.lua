function BlockQuote(el)
  if #el.content >= 1 and el.content[1].t == "Para" then
    local full_text = pandoc.utils.stringify(el.content[1])
    local ctype, ctitle = string.match(full_text, "^%[%!([a-zA-Z]+)%]%s*(.*)")
    
    if ctype then
      ctype = string.lower(ctype)
      
      local alert_class = "alert-info"
      if ctype == "tip" then alert_class = "alert-success"
      elseif ctype == "warning" then alert_class = "alert-warning"
      elseif ctype == "danger" or ctype == "error" then alert_class = "alert-danger"
      elseif ctype == "note" then alert_class = "alert-secondary"
      end
      
      local div_content = {}
      
      if ctitle and ctitle ~= "" then
        local title_div = pandoc.Div({pandoc.Strong({pandoc.Str(ctitle)})}, pandoc.Attr("", {"alert-heading"}))
        table.insert(div_content, title_div)
      end
      
      for i = 2, #el.content do
        table.insert(div_content, el.content[i])
      end
      
      return pandoc.Div(div_content, pandoc.Attr("", {"alert", alert_class}))
    end
  end
end
