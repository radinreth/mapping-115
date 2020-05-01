xml.instruct!
xml.tag! "mapping" do
  xml.name "Mapping115"
  xml.tag! "global-settings" do
    xml.variable name: "service_domain", "display-name": "Service Domain", type: "string"
  end

  xml.steps do
    xml.step name: "caller", icon: "gear", type: "callback", "display-name": "caller log", "callback-url": "http://{service_domain}/caller_logs/" do
      xml.settings do
        xml.variable name: "caller_log", "display-name": "caller log", type: "string"
      end
      xml.response type: "none"
    end
  end
end
