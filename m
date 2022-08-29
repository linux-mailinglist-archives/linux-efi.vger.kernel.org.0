Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4761E5A5648
	for <lists+linux-efi@lfdr.de>; Mon, 29 Aug 2022 23:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiH2VjJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Aug 2022 17:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiH2VjE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Aug 2022 17:39:04 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8AF84ED8;
        Mon, 29 Aug 2022 14:38:58 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TKWKeE001503;
        Mon, 29 Aug 2022 21:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=CpVq0+cJCMFWSpE7UL4+jVLdlAXZ330ylvMcas2YE3M=;
 b=jab1VVvtCX2Vs7rpOu6gXztYgls2jsTk+baSwCJVwkvKVJrkme/XamBdFw000Bnaqj8R
 RWZeV9k2oF/MedLCS2cFk6iSop2gZ8tpOuUhiFGPUL2AU2SmFk1qf3EUOaPDuEgZ9TqY
 VW24crzZlzhCBqP+6o2aq9Ev6GMNbEDfnsFqrvNu0Qknh5hR6BGs853kG6haPfX/LWBA
 BQYAdRVufcTdQjsKoUKgM1m5/affVCystrWEhZSdxMI4KGoiCnxTfwyupmwAYEidj5Uf
 OR3O9WhPofNwkWkUPTrMRSr/veXdDnvkJuXZPYmnBh0IfQQGrK9Yl21aN00jZ4sL6o5W bg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j940hrnem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 21:38:07 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 0254ED283;
        Mon, 29 Aug 2022 21:38:04 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 29 Aug 2022 09:38:03 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 29 Aug 2022 09:38:03 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 29 Aug 2022 21:38:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5YUPvW2K1JstUzLHqsbiQ2IqvVLKPlPD7CaujK/W1eMMJLG0vbuYAAB7QQHcjgX+Ol/g38kuN2HNcJLUA36vsOsgq+KJCAW+HwYYF04tSBXd/aHzX4jVik8phQGjG7U/q4aphzLH+axkcM8anF5A0tQCXqt130Q6BuEvERaVQqb49Ky47md2QwZ+YzZhnZlZIadNtSWUfzW7FWkLBS2H2OysXTFZFkI6Xf21iCcd1C8C2Mlfa/TMVJPg4Z8KPza+KkaexoG5G7S3pgwEYnBTkyIoMvG+IX1UQeGjLeiwTMHbBOGRom1jL5hoBCMfw/lKp2S7qBPUUnHHcm69cEdFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpVq0+cJCMFWSpE7UL4+jVLdlAXZ330ylvMcas2YE3M=;
 b=VJGaeeqqwINQEuaiiOuhLqTdonUAOuF4N8SoQVcoRyiQY8Z3gAGivmdYOYyuB985s9fyeKc9X7NSP4SSAzK3kALXQtgeKXjxMqh76us7cO9QeMRhTbM/iUlptUQMWo5nPt9GFIPeOJdXLVjrMMYv7ZgyV6E60KH5Jxo3ZKfg5TWkavjsHHGhK1dqBoD8vAbFF6wUUG3f0L0nGqhmLy/wsZZiDX7caf3cbqmAAzfpvJVEBEQc+h7XOh6/4hq6bGY4qhs8c7SRPOHE1LsOqWI3qLremEWGaLpRwdQWIucGo9Kks6Y99xqEtnLKopFYPzRcyLnTXpyNcM7IFJJ6urTn7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7SPRMB0012.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:12d::13)
 by SA1PR84MB3142.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:806:251::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 21:37:56 +0000
Received: from PH7SPRMB0012.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::65ee:f14a:a73a:f231]) by PH7SPRMB0012.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::65ee:f14a:a73a:f231%7]) with mapi id 15.20.5566.015; Mon, 29 Aug 2022
 21:37:56 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Borislav Petkov <bp@alien8.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Elliott, Robert (Servers)" <elliott@hpe.com>
CC:     Jia He <justin.he@arm.com>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "nd@arm.com" <nd@arm.com>, "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>
Subject: RE: [RESEND PATCH v3 3/9] EDAC/ghes: Make ghes_edac a proper module
 to remove the dependency on ghes
Thread-Topic: [RESEND PATCH v3 3/9] EDAC/ghes: Make ghes_edac a proper module
 to remove the dependency on ghes
Thread-Index: AQHYtj5tQS6+//pDoEmz8BwtIUrts63Bza6AgABv7ACAA9aLAIAATjaAgAAId/A=
Date:   Mon, 29 Aug 2022 21:37:56 +0000
Message-ID: <PH7SPRMB0012094F02A587B859AEFDF282769@PH7SPRMB0012.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220822154048.188253-1-justin.he@arm.com>
 <20220822154048.188253-4-justin.he@arm.com>
 <MW5PR84MB1842F7107770654C46CB0311AB759@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <YwmqKPaYtgTS4xYT@zn.tnic> <YwziYFGWyEe2/kIp@yaz-fattaah>
 <Yw0j+5tSZXGW0gDy@nazgul.tnic>
In-Reply-To: <Yw0j+5tSZXGW0gDy@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e711ea25-ecbf-4203-625e-08da8a06bca3
x-ms-traffictypediagnostic: SA1PR84MB3142:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pozN23hq83uqEbxYmCBQIg06XW9Exj/R37P1knUOPZD3wmSu1TPZQW5QiCmX83RKPal8GKN76MQ/szwytlh7/yyOZwLSCvkSIkzJVEa0BDqW9mkrd/z2uT3fuIP3/ZGVoaCynR04ShkgIFKE2QdS6Tw8yiPGPFOobeH0/b33xKfEFRQI6D9rb956i7AgpaZLY4cSLW0HMNgeAvuDvcTqQPi1F5OpkfZn9999vJ+1SWps1O31PK/hrcHwz6mNA80t9fiaoIuPvGJtp4SxYnIphcWkbNwUe52m3+/2HKR4MRwr5rbv5AA7pbPvFWL3Z7SsRM0tMggSBQztaZ5ucoa7rJkCjEOOT7j5h+uG1xYv+YSMTzkCJNXfle55Tut4o/cYsIv0Tanw4Uur9oIE0oDY+R5cKzkHaJmdXX38a1YI9KjqeL5EvPTzoqGTwDU6hAlY3c9UuM6QRJuCCFTUiShd3xfLjuWMvUFWjhev/msUJS2Smv93/d7RiyjTnQFwGlRMvPwEiSqv8CI90bbSzjdchOwEdcjgEdcF0hnaia3rkLgiFlAF0DCRHIrl+8HGCbY/BDX5XDFpe+cD2oEfAzpvZN17DOseuszinxhd6X4aGR+43R4JLhB3Zr93RhIYf2BNx6y/dDnoxOCzBXOLFjYvPlKVsSO0BXF9Sr6ez27My5D1jn3iaN3hjx7Hxf48bv9XZv1CwGqJcV9YVxnq6TcKXZCqjPDoMB8SMdonmNAvMULWBf4asoJC3TXf3ottPZMll9oMP6+6GRrYaipw/XXmqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7SPRMB0012.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(346002)(396003)(38070700005)(8676002)(4326008)(316002)(66946007)(66556008)(66476007)(66446008)(41300700001)(71200400001)(64756008)(110136005)(76116006)(6636002)(54906003)(8936002)(86362001)(478600001)(5660300002)(52536014)(7416002)(7406005)(82960400001)(7696005)(6506007)(53546011)(122000001)(2906002)(9686003)(26005)(38100700002)(55016003)(83380400001)(33656002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWJrbjBObWR4dUlRZEpBeVgvQm5XMWJqYkQ3UXl1b0lFdEtraDdXVjB3eFlz?=
 =?utf-8?B?NkpyU1Y5MVpvdWw4ZDlQQy9wbDhxamFtSktLMmtrVG8wbmRLUHhNR2dsVVd5?=
 =?utf-8?B?aGhqa3pkV1dCZDZQNlRxcWREa0dpc2J6UTd2OTRQanN2TzllWDlDQWswNEJn?=
 =?utf-8?B?YXAzeU54ZVBEY0prVGZwelFmaTdsaFFCZGlHZ0U2em55UjFlMlV2ZnJ6OG5X?=
 =?utf-8?B?L2xONStQWStSbFYvZmJmZnNTRXBGY3ZIZWJZd2RqYVcrY2RaRUQwM0ROdGpr?=
 =?utf-8?B?VHcrSThjTlpodDVNOTMxM1BNTE1IbXRqUEhxMmhta1UvYUZJN0FCYjF5d2RN?=
 =?utf-8?B?ZW9XNi8xMUdpRnNvcmQ4ZWN3RzZ1azMrSlNOYjd2eVpwV3R2SEVyVkRreHpv?=
 =?utf-8?B?K2l3QmNtZEpXeWQyZUNzRmxueDc0RVhjUWl2ZDhlTHYweWRhQUdVV2dySVF0?=
 =?utf-8?B?Z0puV0g2b05VaFRqK2xmSmJGcUR1ZklKTjFQMWpXNnlWZkxxT2VSRFFrZ2tJ?=
 =?utf-8?B?aU5FV1cvdmUrK1NLRDUzNEkrRERncWxrMm5HaVozSVUzUjhObjFCVzhMRW1i?=
 =?utf-8?B?WTk0Q3RwUW5ycHh0RHZJMTNvUVYxZHQ5YTkwbXcvUGpoOTR6ei9sOVVMS0tQ?=
 =?utf-8?B?TzBUMzZ6MzYvdnNVbG1HTW92MFpGZ29TMndxblBPSVVIMU1kZC94ZmNWUHRD?=
 =?utf-8?B?T0QvOGNvQzVTb0hZRHFWdDg0b04vVUpNUnNYTXJwaktNNUlHb0lEMjlGUk5K?=
 =?utf-8?B?bzdCaXVuc0FuZDk4Q0ZZMlNHeWJzdTFIei9UM3ZwWXRkdE5yQnNSbllTQjk5?=
 =?utf-8?B?YjVta0NGL3NseVBYWG5hZGZGek1HOGhLNjc2U1QxMm5zVHRjblAxTUJyYVNP?=
 =?utf-8?B?YzBMY0ZyMTlQREV6cmNSRnhKMWI2QnJkZHlaUmIrUFFicU9sWnRoVGVOamNj?=
 =?utf-8?B?OVRKQkR4MVBOLzJ4cXpLKzE5UGdDcDVwZ1pQTnBNQWIwbS9oUEltNm9ZOERq?=
 =?utf-8?B?eTdhRC9KL1dsVDZhdTVTQkVmcDBSK2p1OFpObmh0cnd0VHFBcnBGNWppS3ZK?=
 =?utf-8?B?NDVmSTEyRUlUOE1JTlNRYTJIUVJMbEtib0xueVUzV2s2MDVXMzFIY3NsUlZq?=
 =?utf-8?B?Z1NzSm1mYUtudUlGbkZYUG5uS3pGbUNtZG9RQ25XbytGQVc4UzVZRy94azMr?=
 =?utf-8?B?YTU1b1Z4NEh5dXNZSmIvRnFvQWovZzhhNldOT2duV2ZFc3RhTVJsVEdsVmJL?=
 =?utf-8?B?RUtPaXk2WkVLckx1K3BlRTVrZnFwbGpRZy9SZ1FETnM0anN2ZGt6VVRNY1ZT?=
 =?utf-8?B?bk9WZWtjSTJnY0JEL3hsSSsyYTBoMFN1V3RpZzFYNGZ6SW9NVjgyTkFhdEIy?=
 =?utf-8?B?bW0wcEN3OU4yMmJ1ZGZ5TXBBTlJ5RDZ6aVRabGZDTmlTbjNVRFQzdjdnZ0Nk?=
 =?utf-8?B?NTRNWitpSXp3ZVNRYkJwUDNUekdQbi9Xd0xFUDZxS1VaZ1ZGK2RiZE9QcjVj?=
 =?utf-8?B?dzN6WnZOcVBGWHRyRHdZbXlOWE1vMEN1ckZJZzczaFIyOWRBU1hkbXNGbEV0?=
 =?utf-8?B?TGt5MktzM3hxUUdub2tNR1lPNzhSWlIvTjVBZU0zOVRYZVBIcEdWQVhDNU1r?=
 =?utf-8?B?MGNNWS9XdWZKbGRUTERUcDJ5V2twY3JMdnBzcXcvZHEwZkwxOE1aVXBmVTla?=
 =?utf-8?B?UmNkaElKU0s5QUMwNElvV1hidnVYTGN4VWpFR05uMDNtY2l5Q1N0cGQ3VXE1?=
 =?utf-8?B?WUwxa05hK05lR3JYYitTaXhrbDAyQmJRTEJWc3dnelhZa0RNTGUwRFJ5VnU4?=
 =?utf-8?B?bmhhSDFZakhYZktqRTFIMHNaTkhPanR3Z1hQUHJRVW8rMTVIQUJaeXF0b3Jk?=
 =?utf-8?B?MGRzc1diRzVLaTlERFNrNzA1Uys5MUhFeEZaK3labHN6UlBSN2hJdWdNUEc0?=
 =?utf-8?B?Y1U5cGVTdnhsZUpWQjVhd3RFZU5oemlveTdkNzdid2tqaHE2K21KUm9kT1VB?=
 =?utf-8?B?SzZWR0RpZkZtNzlKVXV1QmxGbkJSc04yY1pFRGJTVlQyMWszc3c2VWxNNTZQ?=
 =?utf-8?B?VFRPWTZ2Wk5zOTE5SmFVSjZsVUpxMnBzVjRxTlJoY2Vyck5hNjZGT1EyOGR5?=
 =?utf-8?Q?XcR7llixS8Sf8thfOntvUaEYe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7SPRMB0012.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e711ea25-ecbf-4203-625e-08da8a06bca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 21:37:56.5295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWJIBCrSlVSs/frFzqbCCb9P6q0s9uVS4sb1Yaz0cujTZwOWERglKL61LOqX9YC5ZeLkM73O4eDbrCJTMSyHtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR84MB3142
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 9eagZLlx0nQ1_ErQURwyYX78KBhceJR_
X-Proofpoint-ORIG-GUID: 9eagZLlx0nQ1_ErQURwyYX78KBhceJR_
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_11,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=600 impostorscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290095
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gTW9uZGF5LCBBdWd1c3QgMjksIDIwMjIgMjozOSBQTSwgQm9yaXNsYXYgUGV0a292IHdyb3Rl
Og0KPiBPbiBNb24sIEF1ZyAyOSwgMjAyMiBhdCAwMzo1OToyOFBNICswMDAwLCBZYXplbiBHaGFu
bmFtIHdyb3RlOg0KPiA+IEdIRVMgY2FuIGJlIHVzZWQgZm9yIG1vcmUgdGhhbiBqdXN0IG1lbW9y
eSBlcnJvcnMuIFRoZXJlIGFyZSBwbGF0Zm9ybXMgd2hlcmUNCj4gPiBtZW1vcnkgZXJyb3JzIGFy
ZSBoYW5kbGVkIHRocm91Z2ggdGhlIE9TIE1DQSwgYW5kIFBDSWUgQUVSIGVycm9ycyBhcmUgaGFu
ZGxlZA0KPiA+IHRocm91Z2ggdGhlIEZXLCBmb3IgZXhhbXBsZS4NCj4gPg0KPiA+IElzIHRoZSBI
UEUgU2VydmVyIHBsYXRmb3JtIGd1YXJhbnRlZWQgdG8gYWx3YXlzIHByb3ZpZGUgbWVtb3J5IGVy
cm9ycyB0aHJvdWdoDQo+ID4gR0hFUyByZWdhcmRsZXNzIG9mIENQVSB2ZW5kb3IvYXJjaGl0ZWN0
dXJlPw0KPiANCj4gL21lIGxvb2tzIGluIHRoZSBkaXJlY3Rpb24gb2YgSFBFIGZvbGtzLi4uDQoN
ClRoZSBIUEUgcGxhdGZvcm1zIGVuYWJsZWQgYnkgdGhlIHBsYXRmb3JtIGNoZWNrIGFyZSBndWFy
YW50ZWVkIHRvIGJlIG9wZXJhdGluZw0KaW4gRlcgRmlyc3QgbW9kZSwgd2hpY2ggRlcgZGVjaWRl
cyB3aGljaCBlcnJvciB0byByZXBvcnQgdG8gdGhlIE9TIHZpYSBHSEVTIG9yIA0Kb3RoZXIgbWVh
bnMuICBUaGlzIG1heSBpbmNsdWRlIG11bHRpcGxlIENQVSB2ZW5kb3JzL2FyY2hpdGVjdHVyZS4N
Ck9uIHN1Y2ggcGxhdGZvcm1zLCBmb3IgaW5zdGFuY2UsIEZXIGRvZXMgbm90IHJlcG9ydCBjb3Jy
ZWN0ZWQgZXJyb3JzIHRvIHRoZSBPUyANCnNpbmNlIEZXIG1hbmFnZXMgdGhlIHRocmVzaG9sZCAm
IEZSVSBub3RpZmljYXRpb24uICBDaGlwc2V0LXNwZWNpZmljIGVkYWMgZHJpdmVycywNCmRlc2ln
bmVkIGZvciBPUyBGaXJzdCBtb2RlLCBpcyBub3QgbmVjZXNzYXJ5IG9uIHN1Y2ggcGxhdGZvcm1z
LiAgRGlzYWJsaW5nIHN1Y2ggT1MNCkZpcnN0IGVkYWMgZHJpdmVyIGlzIGFjaGlldmVkIGJ5IGVu
YWJsaW5nIGdoZXNfZWRhYyBhcyB3ZWxsLg0KDQpPUyBNQ0EgaXMgc3RpbGwgdXNlZCBmb3IgdW5j
b3JyZWN0ZWQgZXJyb3JzLCBzdWNoIGFzIFNSQVIgKHNvZnR3YXJlIHJlY292ZXJhYmxlDQphY3Rp
b24gcmVxdWlyZWQpIHdoaWNoIHJlcXVpcmVzIHJlY292ZXJ5IGFjdGlvbiBzeW5jaHJvbm91cyB0
byB0aGUgZXhlY3V0aW9uIHZpYQ0KTUNFIHNpZ25hbGxpbmcuDQoNClRvc2hpIA0K
