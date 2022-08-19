Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A7C59A5BC
	for <lists+linux-efi@lfdr.de>; Fri, 19 Aug 2022 20:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350144AbiHSSr7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Aug 2022 14:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349248AbiHSSr4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Aug 2022 14:47:56 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEDFD7411;
        Fri, 19 Aug 2022 11:47:55 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JIUDYO014417;
        Fri, 19 Aug 2022 18:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=hR63uN+ENQXqOE1a1UqNGvLoxyOHFAiaJM4mjfW0Tss=;
 b=NlrJ2xpkOEVnscszhHlpO6jnTldL93LQUeVl69xnHsskUD4RQ5JjvIvvE8PLPVD9Lbpu
 T6zL7NshLBQrrLZybp0krU8Nnnx/YiuCJsmjKm2/+OORmAE2vfvbo1fwps9SXXHRNllj
 /wmxjbYu5eFIn25JCaKvy6IPhaKe03prEDZiiqsSFX9blHWK+xnMRta/Z+Xc9rou/nn7
 AA7dLq9r33BfGD4NeQZCwpmu8vRgWJ/fTW4D13zN0lK2qi6rLkNZMdZN4FuXMRITcbk+
 HFiM7OyBfXlHvL/mcgC+Q7HoN8HJocDJW+52Qk8S6O0PGFizqyXujEEVEa0gBvOOzmCd pg== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j2fuer7rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 18:46:59 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id B2321800E8C;
        Fri, 19 Aug 2022 18:46:58 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 19 Aug 2022 06:46:36 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 19 Aug 2022 06:46:36 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 19 Aug 2022 06:46:36 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NP14HdcmR3pWLF3p1Vp7JyJ9HNIhkYYAVjHN6a6IK72msBTtJimGgOIlpjo4oXxPPhZa8uHEdCYr6fneof2Mim/oETuT4J6sUv4F0n0enHOc8WTqJ6HNYtLk59Eg7e3AttGiQGeTBt14R5lpkNvwIP+P1XQvijHjUz3t4qV+FMQ/mUXZkc1FhBYdo3zevDd1ChPK8B4iaf5nBm0SZ0Ko05lZOqc8pp+H+9OyVvR977cQ5wwtPK4nDYjTCPYlW2FIwIXyWx8Rt3oHlDR2J5Nm9qJyjWsUFzrDaNlgctl4t4JAb2BFdetIuVh1QgqQUzZNb7XOx7HQ7DClJvVNo1e33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hR63uN+ENQXqOE1a1UqNGvLoxyOHFAiaJM4mjfW0Tss=;
 b=Z+un2RCLjCddUT8JyzCBIW8dTxsdGTIq6fa3+N5Yxn/StCSMaahIBLttARxzCFT5G7g1Eb1+dxZ3c8uARMLk9ksBykrA1x+1RpoTwU+KvSVEbLTwOaMxopeGFPHiuvVY4upzjOI9v8QwDo/bV+TI/C8IV8pr+2XfgNJlMkqOMSmN6WgtLM7r9DBXqxVQdpQP9zBqz+xDjoCgHNt+PDnefw441zjVwb8+jP6GZUPK9CvNv2OeHFs9ivMAya2hHcv+PewcUAqG1riXARHdAdO73R7z1v148pM1aZx582vqErs4NCr/H7LysP4/b89ILLMkmJp9bQaM1JV4VhW0s77bfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4c::19) by
 PH0PR84MB1809.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 18:46:34 +0000
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6]) by DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6%5]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 18:46:34 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Justin He <Justin.He@arm.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: RE: [PATCH v2 5/7] EDAC/ghes: Prevent chipset-specific edac from
 loading after ghes_edac is registered
Thread-Topic: [PATCH v2 5/7] EDAC/ghes: Prevent chipset-specific edac from
 loading after ghes_edac is registered
Thread-Index: AQHYskazgdaGLeNebEWQzyv29780RK21ZjbQgACj04CAAE7iUIAANdmAgAADCCA=
Date:   Fri, 19 Aug 2022 18:46:34 +0000
Message-ID: <DM4PR84MB185306C2C0DE95FF408173BA826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220817143458.335938-1-justin.he@arm.com>
 <20220817143458.335938-6-justin.he@arm.com>
 <DM4PR84MB18538A56870A280CDC4637A7826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
 <DBBPR08MB453891E87563F1BBE291248AF76C9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <DM4PR84MB1853B213F2F45E495D9D6446826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
 <Yv/Wm/Zf0kdGgT33@zn.tnic>
In-Reply-To: <Yv/Wm/Zf0kdGgT33@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af690728-58e4-4461-3abd-08da82132411
x-ms-traffictypediagnostic: PH0PR84MB1809:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uQ93GodB0slKwwPE+azUDxQpKo1M9NCSbHfDj8FJfeGwfKA1MslJmlRU/3oD4ilNfuf6V9L+E+Tpu4n/5MwkKhZJnlENB0rYjwA/ECW3vRdp0T9bxqrbbG95+EE1/V+MsJSHVp7HOCjjhBcejs/ud64zBEqw/1p9YegNkJIavV4xMRt6jsjlMINu/dXillOYIU4gE6mY3/CbdkUEOLU3yTEI+DBQUbItBiBzIweO/KaNwWNk8I/CnXxU26zIqhYUL89VkQvyYSVWKPqdQbfJ7g88P5W2q8d03g8lxWgJjrudtcdFGZnNnGmduzVfljLGplrraG6zvK1bD7mGBTqCHnlC4PglCay++6RgG5gwTyDg6t7OsyU5SyBb/D0jnnKJEw5kXoYlyYy72jxb68dctjc6TERptERzSk9T0WoSQABMk/rsF+wXdMi+BaPe4/ixKy45+AlgTe6bzhSRGb4d1cT0xz82wN7NHTTSfmVOWVnWBMBjukNbV5trPQQGyeJHrPRjPFhGSmkshZPRJZwAdkpPeuPRZxxOYCU2a1p3mtDO/YnV+OGqBHuR5ZGas+9/49cLH8ao84dcypZpvHiLodWYkzgC+hB87w1SvNqe1S+Z8yqtHKrk051utqujmUFiC3+nzj4VVBW0MbRJ0aOiRpjtesueijdP2JXH5USrGhDZp2CjLlOHJcRtBwnlMKOOI9qOGT5FF41yFiPa1t6Zrq2bImvZjeeyUcuM1+OvDrtmLM1VbP5YZGN+lDGNNUrb+7rkEAQFsltfwdO3ZkjexQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(136003)(396003)(39860400002)(346002)(8676002)(122000001)(82960400001)(86362001)(38070700005)(4326008)(76116006)(66476007)(66446008)(64756008)(54906003)(6916009)(66556008)(38100700002)(316002)(66946007)(2906002)(4744005)(5660300002)(7416002)(8936002)(186003)(7696005)(52536014)(6506007)(9686003)(53546011)(26005)(71200400001)(55016003)(478600001)(41300700001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUlzNFQra21WeDExdFhsZXo2MW9ydGtmM1ppNEVWQXNmaEIyQ2Y4NFNWek50?=
 =?utf-8?B?c0VjR3o4MzNCRzkvUHgyb3NFQ0loemp1N094ZVE4UDM3MFZBdEtBZFAwWmZD?=
 =?utf-8?B?OHh5b1V3eUJPeVE2UEs5VEZITys3MXl0Y0RsQzRWWlhxczdZRHdIa3FTWXZp?=
 =?utf-8?B?S3dBbisvRkVVMkdMSzFrR01EWWZqVjVxYUcyd1o3d0tBZ0NEUS9sejFwSlBx?=
 =?utf-8?B?UUY5L1NkaFR4b2JjNDl3Z29BOEo4ZTdTemtQbnNISytrTVZxMkE1cEhBNC9l?=
 =?utf-8?B?SU9rbGk1WlhyeTlTM3A5dFFYYkNDMUhVb3ZrNVJZZWs0M2V2Nzd2SjBmNmZr?=
 =?utf-8?B?aExxcTJ4R3FOei8xZUpOTXBuaWZ5QXdJZlRUTVptTkpBckhGcWxVTEN6R1hW?=
 =?utf-8?B?N1gxYnR6K3ZtUHpiZGxva01nbjBBM2pZQjQzdUhyYTJjek11RlArbjJXWTYv?=
 =?utf-8?B?VnpTejRkRFpZVGRRaUwzbVU2Q3FtMXZGbzZaNTBPRyttemNkcmgrOUpneUJQ?=
 =?utf-8?B?eldNNkVvWjc4WmVYRVhVNDZFZHhGQ0ZYZXNITExEMGs5cnN0VFExbi9DTFZ1?=
 =?utf-8?B?dHVha0E3YkIrVko3dFhoR1V0dWhGZnA4NXl5YjNpY0I2NGR2V1NPNkVPNUlL?=
 =?utf-8?B?WUkydjA1VUVjSVluTGVySHRlKzlnOTI0Z3k5L0dYOWVtYTQ4b2JQN0N5T24r?=
 =?utf-8?B?V2xucVBaVmFISzJRNENoWVZ1MjdTWW1yREgydk1BVXNDblE3Q3djRTZ2SzlU?=
 =?utf-8?B?TFNVUE4xVlU0ODZmRFRjZTFYcUJDTHM4Z056d2Q1UU1OM3pTZ1ZmZnFOYnM0?=
 =?utf-8?B?QnYxdHc3NWVJRDFRaThVWE16MC9OZ0ljRXlYYVlDenJJUU1YMHlYWkdqdzk1?=
 =?utf-8?B?aVpjbGp0MkFOZlBjN0RVeWJ2S3drekoyUkttS3dRRTRtd0VFZFNaS1hnSW0r?=
 =?utf-8?B?b2ZZb2RoNHlsSUJIc1dhMVN3d3U3NzdSd2Q1SlJwMU8yMkhtY3JQNzV6RGlj?=
 =?utf-8?B?cVBwc3pqenpYZHdoQUFuWjBscUtpMVd2VGk5QkhtU0Irck5BVHh2bXZLaFdB?=
 =?utf-8?B?alZZQWRPdStCUWtpbSs0RGQxSFVWbmpzd0t6dUZNMFF4NG1GdXY5T3hnNWZZ?=
 =?utf-8?B?TGpSVjJISlRuVkUwdjlYOWhMWmN2ZGNacy9lU2Q2eHFkWlFubmVGbGF0SlBS?=
 =?utf-8?B?Y2tkZnJuc0xLcDN1STRjN29xU3VjYVhSdlRORitWalU3OWkrN3dLcWdCdlgy?=
 =?utf-8?B?K0lqa1lJc3BkcEV3ZWVGNExlNTRJR2hQeFBwcjVwVGo2anJLanltYWpFL01Q?=
 =?utf-8?B?UEJlUWNFY3lxREJUUksxQ0c2SzZrT3czaUVxcTZzMi9yZi94RGJIcXNzZms0?=
 =?utf-8?B?UXVRQkN6clNFRjFTMGZ5NTVJZUgyUkZJQklmWWNEdTM1NXRXVU5iWGdpVWVm?=
 =?utf-8?B?N25XK2M5amE4WDFyZ0Y2TEV6SHp3T0dsajl1czRjWkY3RkkwWlU1TVFYeUZE?=
 =?utf-8?B?ZkNmT2VLb04wM2hGUWhVM0tuQXI4R1dGYUwrVTRSMWplbHdudkVoQndmakJN?=
 =?utf-8?B?T2N0d2YxWUpVenJwRjdxczM1Y0VqcjFyOEFuYzN4ZTU0QWU5RXA5SDVEOUM2?=
 =?utf-8?B?Ynd5Y2xhRm9qRGJodjhOWkRWWFg0dWVFUGRyMXovczkvZ1pKY0wvSFJkclFW?=
 =?utf-8?B?SEZ0TjArL3Q1QlpmYWdKc3h5dktWaS92RG9zNjkyWllNTW5nWjhJaEVjK2tL?=
 =?utf-8?B?eXRuT2x5TStNaGg2blhEbXBCaUJ2OHZPRjduaG8ySEFDWk1NSUVURGhSQncw?=
 =?utf-8?B?ZVhBRE1jRWhTc2JBR0t1UzQxNTZybTNJeWYzOG9aREJkU3E0dkpNTVMzY0h6?=
 =?utf-8?B?UFZ3UmhlMXV4UnhxandCdkl3aFE2NmNSYXdrSm41RGx6N2pXR1FlYlhyQkNv?=
 =?utf-8?B?bk4rMWtzeHhueW9uUVZKV3V2ZG04MW0wOFFUS2NCQTd2NHFuUCtSTndxMzBE?=
 =?utf-8?B?N3dWbE9INHR2Y0ptR3JXcnlUZzdPMDRaOE13ZXArSTVmS3hQcEVtZ29sUkY1?=
 =?utf-8?B?czd1QWJ3K1YyVG8xMk41VWVtT3BLbCs5VlBoR3lDandpWEo1VTNYVk1CdEg0?=
 =?utf-8?Q?rZbgDJoKNt1zy0nV/f+EQTANF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: af690728-58e4-4461-3abd-08da82132411
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 18:46:34.6820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DLUtC4UeGvAqDrKuTb/WX/0cXb76hueds4bTB5KnIYOFcSso1KRVHOKEikrD2/52LX2BTMJ9b5q2k/y79Af77g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1809
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: Ae9SGlUkBZhljh3OJoyc8u5tQilfI9Zt
X-Proofpoint-GUID: Ae9SGlUkBZhljh3OJoyc8u5tQilfI9Zt
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_10,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 mlxlogscore=937 impostorscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190069
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gRnJpZGF5LCBBdWd1c3QgMTksIDIwMjIgMTI6MzAgUE0sIEJvcmlzbGF2IFBldGtvdiB3cm90
ZToNCj4gPiBUaGlzIGZsYWcgaXMgYSBzdGF0aWMgdmFyaWFibGUsIHNheSBnaGVzX3ByZXNlbnQs
IHdoaWNoIGlzIHNldCB0bw0KPiA+IGZhbHNlIGluaXRpYWxseS4gZ2hlc19wcm9iZSgpIHNldHMg
aXQgdG8gdHJ1ZS4gZ2hlc19lZGFjX3ByZWZlcnJlZCgpDQo+ID4gKGFrYS4gZ2hlc19nZXRfZGV2
aWNlKSBjaGVja3MgdGhpcyBmbGFnIGF0IGJlZ2lubmluZyBhbmQgcmV0dXJucyBmYWxzZQ0KPiA+
IGlmIHRoaXMgZmxhZyBpcyBmYWxzZS4gSXQgZG9lcyBub3QgZ2V0IHVubGF0Y2hlZCBzaW5jZSBB
Q1BJIEdIRVMgdGFibGUNCj4gPiBpcyBzdGF0aWMuDQo+IA0KPiBXaGF0IGlzIHRoYXQgZmxhZyBu
ZWVkZWQgZm9yIGF0IGFsbD8NCg0KQmVjYXVzZSBnaGVzX2dldF9kZXZpY2UoKSBhbHdheXMgcmV0
dXJucyAmZ2hlc19kZXZzIG9uIEFybSwNCndoaWNoIGlzICFOVUxMLiAgSXQgZG9lcyBub3QgY2hl
Y2sgaWYgR0hFUyBpcyBwcmVzZW50Lg0KDQo+IFRoZXJlIGFyZSB0d28gcG9zc2liaWxpdGllczoN
Cj4gDQo+IDEuIGdoZXNfcHJvYmUoKSBzdWNjZWVkcy4gZ2hlc19lZGFjIGxvYWRzIHByb3Blcmx5
IGFuZCBvdGhlciBkcml2ZXJzIHVzZQ0KPiBnaGVzX2dldF9kZXZpY2VzKCkgdG8ga25vdyB3aGVu
IHRvIGxvYWQuDQo+IA0KPiAyLiBnaGVzX3Byb2JlKCkgZmFpbHMgYW5kIHRoYXQgaXMgY2F1Z2h0
IGR1cmluZyBwbGF0Zm9ybSB0ZXN0aW5nIG9mIGFsbA0KPiB0aG9zZSBwbGF0Zm9ybXMgd2hvIHdp
c2ggdG8gdXNlIGdoZXNfZWRhYy4gQklPUyBpcyBmaXhlZCBhbmQgZ290byAxLg0KPiANCj4gTm8g
bmVlZCBmb3IgZnVua3kgZmxhZ3Mgd2hhdHNvZXZlci4NCg0KMy4gZ2hlc19wcm9iZSgpIGlzIG5v
dCBjYWxsZWQsIGJ1dCBnaGVzX2dldF9kZXZpY2UoKSBpcyBjYWxsZWQgZnJvbQ0Kb3RoZXIgZWRh
YyBkcml2ZXJzLg0KDQpUb3NoaQ0KDQo=
