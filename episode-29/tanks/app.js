let parseRow = ({date,tank}) => ({date: new Date(date), tank: +tank})

let main = async () => {
  let data = await d3.csv("./russia_losses_equipment.csv", parseRow)
  data.unshift({date: new Date("2022-02-24"), tank: 0})

  let xScale = d3.scaleTime()
    .domain(d3.extent(data, d => d.date))
    .range([0, 600])

  let yScale = d3.scaleLinear()
    .domain(d3.extent(data, d => d.tank))
    .range([400, 0])

  let svg = d3.select("body")
    .append("svg")
      .attr("width", 800)
      .attr("height", 600)
    .append("g")
      .attr("transform", "translate(100, 100)")

  svg.append("g")
    .call(d3.axisLeft(yScale))

  svg.append("g")
    .attr("transform", "translate(0, 400)")
    .call(d3.axisBottom(xScale))

  svg.append("path")
    .datum(data)
    .attr("fill", "none")
    .attr("stroke", "red")
    .attr("stroke-width", 1.5)
    .attr("d", d3.line()
      .x(d => xScale(d.date))
      .y(d => yScale(d.tank)))
}

main()
