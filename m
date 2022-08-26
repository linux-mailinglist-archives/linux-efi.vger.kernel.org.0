Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E4C5A3000
	for <lists+linux-efi@lfdr.de>; Fri, 26 Aug 2022 21:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344005AbiHZTbX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Aug 2022 15:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343559AbiHZTbW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Aug 2022 15:31:22 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6106DFB50;
        Fri, 26 Aug 2022 12:31:21 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QIZ8GC003882;
        Fri, 26 Aug 2022 19:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=dpVPfnAH3DoyCG/QAE/i9UBOp4zU+X43dNY2Jo03m14=;
 b=cRlRUjBW0aIirbcyt8wTCgGfJlO2Qdv9FHydg+ftm037QpWrplXIb2ShnRr9FXPd8zKy
 rZNsUCA9yGBQc6E67sWvGpjepjYN0l9WDLVUpIFWymp+h/u5gx8gEmiXryeWqD+fqrmi
 63tLbkLNXjHyb9GZmq1ikc0IZB0Cx1yWp8pp1Ai4mOmk8cTGjZwQ8seHkp1GHeaHMswq
 z6SWcKjId5hJZ2vtRxfKj9tY+L6myQfsu/fZQaOefefBNaDgoYTLkZ5pOdC4EQNkLMCZ
 /cqVXb9FI9F9yf1UhMum+ipneveR+kRvcjiPnjnJl/QPs9bfDPZBcY+CAet8eejcpcDc Yw== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j73jjraef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 19:30:33 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id F0417804C87;
        Fri, 26 Aug 2022 19:30:31 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 26 Aug 2022 07:30:22 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 26 Aug 2022 07:30:22 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 26 Aug 2022 07:30:22 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 26 Aug 2022 07:30:21 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoVM7l+r6KKd4SlMq3N+odRnQ1eNKhtrEcMgWnv0yS2N20qCDKKUMJm3J7y90FSvWL8HubWz4KTK6eiYWoN8D8JfL1tPJCDlw6Y5iQupDyysy/3XWNyASJmgG2iAHNQLeKhQDPYuvUvMm+A5GhwPylkK/yq++i4/zUDxCe2Gpu8aaPkNYwyqdH0fn+ozdvyDKwMGN0aP1tl0T4TYcN7PyxwT61q9nLqbDDsXYuK+JRM7Xx6oOQoQJJyiXE4OP+F4tIyySyFW5panaeuF+W70QTWx2Kx9ktAKPCoedh3FWMU6wCDkunXoJPVakN9mD8q7rygxTm/P4uZs1SB+JsZzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpVPfnAH3DoyCG/QAE/i9UBOp4zU+X43dNY2Jo03m14=;
 b=WdZ9Ywgnta/nLwH7UYKkzE0h7V/IXx0IOsp69G25FSYzqhmxRjH8OACvowHHfqIJyJmEsTFcs5kgaAkYSLw1V09h/ZVZAOALZgDQw3T21DihprNZFP2Rv0quW5dCKfP7wL7ELa2qJvtUhtRXEp+mTwf3Xh16knz4W6mtj28Fju+r2cKhDVGCcw9LPXdxHZvaG8+pewxALQPsk4eFPEdyovCC5Kk39bERor/Y2FyY0cm4LAzu5B9rWoMF8XTOGYK3m0STP4yrLLUv9N/XSYfsoNSJXQ/LtnFWmtPSkjX0wtQTV/8Z+q2hVp875c1U8Mg0jXnblhyN14Xj9Lg/4Hl00w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4c::19) by
 PH7PR84MB3225.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:1ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 19:30:19 +0000
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6]) by DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6%5]) with mapi id 15.20.5546.016; Fri, 26 Aug 2022
 19:30:19 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Justin He <Justin.He@arm.com>, Borislav Petkov <bp@alien8.de>
CC:     Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Robert Richter" <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
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
        nd <nd@arm.com>, "Paul E. McKenney" <paulmck@kernel.org>,
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
Thread-Index: AQHYtj5tQS6+//pDoEmz8BwtIUrts62+MkUAgAFbnICAAgjg0A==
Date:   Fri, 26 Aug 2022 19:30:19 +0000
Message-ID: <DM4PR84MB185308834381DD3316D506A782759@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220822154048.188253-1-justin.he@arm.com>
 <20220822154048.188253-4-justin.he@arm.com> <YwZFqHvcEzVpAxzn@zn.tnic>
 <DBBPR08MB45384B8C447B9B4B29D07011F7729@DBBPR08MB4538.eurprd08.prod.outlook.com>
In-Reply-To: <DBBPR08MB45384B8C447B9B4B29D07011F7729@DBBPR08MB4538.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77b9e383-bc36-4996-a5e1-08da8799696a
x-ms-traffictypediagnostic: PH7PR84MB3225:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rQGYeYHfj36LCrwVBZsCMDPRc6mR852ZBbKIBS0Uzsy2p4ccGHoEjCNxbCRfTQiE3qBGabByyw84uKhAUGlCfIDdUghkxHy/AFRc4bfjU+gPwvmCRkq4XQXQ9M/cenkuuutTtrLZJJUJhWKgUvY6wMIt7cRuyLuws9XhZBjaqsZHgMWxVmGTWptVxtoiZUFhY3EsaaE66eKnldUhkVexDuexcfuVFY/DnCp+MVJIuFqvUQUZsBrHhK3QRYBsZb7s0d9nU3LkAWmaEglA9i6rAzhD7/YeSq3UPPAO77R6WSHh0iTtAxLhmzTidlgW0S8PZtgtF8Tvn//6fJvOJiZYPIjxqge/KrD+JY3NF5kkHnIQlJMaNkrA1hOGGjSwFg8v+vIAEFYYD3AnNw7h4bdLRXntjdpAnCdhVJleHg/TUZxgcSypJc6HYVyTJ1rlckq2qarFj+voEI9Np9gpIItkzTdNHfA4qnsTj2NaZ1EaDgFsnYqBUQoWtESZsHT1mkS0Kmu9o+sWY07WVncyQE50KnK2lw0Qn7mlSXJNL6vSF+H2T7qq+ygMpA88D7QK0bm/2gL+K34ZoDl813io08/ezqxo7WjObrfQBFwrm8KnPK8iYZHU4rih5SimO9XIxqpiaIc7I+u/mSCgx5oLE717DMn1XeBeawpEynU+xpMtsQhxmXiqAhlfiDgyOtWLsLD2q/4+AeDCYki441auybnAtj1+H5FYB3+D1dnUlEwDDqdwyt27oeThVy9SSbNVs4N6GF0KLYGYdBNzqGbpd6tnuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(396003)(366004)(346002)(5660300002)(64756008)(2906002)(54906003)(82960400001)(66476007)(83380400001)(316002)(7696005)(38070700005)(6506007)(110136005)(186003)(71200400001)(55016003)(66556008)(76116006)(52536014)(8676002)(66446008)(122000001)(8936002)(38100700002)(4326008)(7406005)(26005)(9686003)(41300700001)(53546011)(4744005)(478600001)(66946007)(7416002)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2lsaEE1UGI0TzVpNUFWdWN6M3E0S0RRUXpJZ3hDY011ZlNQK040aXQ3emtr?=
 =?utf-8?B?bFY1TFhzUENieTJqaDNZZ1ZuTjRjaklDRFVTTTN4WU5HK0tta2NvOERLMm9H?=
 =?utf-8?B?Y1NtUWpPWm9sT2JvOGZ2aDh2ajFkaGxEZ1dKZzJxMHFaSFZlYW5zTk45Y1lj?=
 =?utf-8?B?MHZObXN4SDVjdTRlcjFrRVlPQkpZeGtycm5ocDBGNDUvaytTbEpNNGhJUThY?=
 =?utf-8?B?SVZkaXNpSlRGRjlzM3ZNWUlYWU9jZ3U2RTh4V0RzV3IycDBoblhES3F6RW1s?=
 =?utf-8?B?d014b1BHRlB0UjFENkRJVGQ0ZVBPOUZBZDFUb2RObEQwaU1RT3dXMENiVnhC?=
 =?utf-8?B?NTBSZDJaYnh5bHltcHZFdDcxeHpxM1hicmpDYmtvLzhvSjBheXhIblhyMjFz?=
 =?utf-8?B?ZkQ1SkxYQ3V6elJGeW1YRmluVWVKaUNXV21aSVF1cUwwV094eCs5ekhqQlhM?=
 =?utf-8?B?RTU1dWhlc0cwaDZFSXNYWjVBdmdrK2JlQ3FucjlqT3Q3dEp2Y1B2U3dzdVhR?=
 =?utf-8?B?YmhiRG81bmh0RU8ybm80SHBjajBiOWQzMzB2VHBVNjZHUURMbXdZMzdmQUVQ?=
 =?utf-8?B?bXdLMnNlaEFqUjRZN2xHMEppUDlIeGpsemFjeEtkNFVVTitrYUtyelNLc2pZ?=
 =?utf-8?B?cVc4Y0lhL3lZUjAyWHI1SmNib045cW5TNjhpTUJaR25qbmEwQ3poNjVpRXFN?=
 =?utf-8?B?Wm5zYUR1RXRGN2duTzBlR1JSWmI5VVhoZTlyTVd2dENNYVBDNU5MblBGdk5D?=
 =?utf-8?B?YzNiSk1SV3RZRS8wQmhDTjd5dzYyOTZkVGRxTGhjUlJWK1hWQW9TZVl1YzYx?=
 =?utf-8?B?YTVmM2FsWW5sRy9nT3F2R2JvMDRBRUxlYmVkNlo5OWRCWldSSHZDQ0phOW1X?=
 =?utf-8?B?L01rRFJmTTlQNFZZTitTQkI5NUxWQVNjQkZpRGtZUCtZcnhHclN4TzB2WmZW?=
 =?utf-8?B?QnZnV2t6U2pZSmxkT1JTZTlTOXVJMm5WVkFiOWhCSGFMOHU2aCt6QUFyN0w5?=
 =?utf-8?B?T2U1d1pLbmFCUzYyOVNFTGR3ODJ4U3FGVGlXaG55TXlDbSt4M1RFZmNZbkVD?=
 =?utf-8?B?OUx1SVdHYW1ST3Z4RjJqSXFXdzdaNXIrb1dydDQ1QXJDWE9nc21rWHloYnRM?=
 =?utf-8?B?OVowMzNwTVp6cXZKSHJneWUxMktUVnV3RHNnZTZ5eW4xclZMbGhEVjEyOWJZ?=
 =?utf-8?B?Y0VHcXZnK0h0dXRmdjlkd25MaVhWOVUxNTV2eTJsS2FoeXBkWEVkWm9VUUpk?=
 =?utf-8?B?WFdhSkxlUklHNlhQZVpCNStqNFR1dG9DUVRiT3FQaHhCbW1nZzJVUUZGeEJI?=
 =?utf-8?B?QWRpNlYrVVJCOU5KUnFCbTZBR0FuUm9QcVVtUGJJWTQ5OU1jS2xzeHc1ZGhF?=
 =?utf-8?B?NDdiWmFhdlFFRmNVbk5jQjEzdkNHMzFONzU0ZDF6U1grTTNoMWRpd0V5V053?=
 =?utf-8?B?aEtFcjF1MnJFN1ZqMi9QS3hZN3g0UnFFVm1FQ2NZeW5zMzhzUnV4dS8vZEpv?=
 =?utf-8?B?M0l6cTl6OFUzSDNLdjdMbDE5Z2pWZVNrM1RGVWYzK0FVcG4rLy9kWmJDNFh4?=
 =?utf-8?B?aTUwSEZNTklGYjBRM1BFNVdtKzJjQzRCVGNxQTg3b0pYRHRzVGM0ckMwT2h4?=
 =?utf-8?B?cDF1OCt5YWc0OEtaelhoRkdVV0pWdDhzZUh4N3VOWm5CSC81VHlTL2FhV3E2?=
 =?utf-8?B?UUNwemJmL1hKWG1OZ0lzSUtNcVNPSmxKeFB2ekhFK1ViWDRab2pLbXpOSmE0?=
 =?utf-8?B?M0NlczZGVUFMb3d1YWcrR0d3Mit6RGRnMjhQeEV6OEhZbTJieWswc0pDZng0?=
 =?utf-8?B?NXc2d3NsdFFQL05TMFpqbmJKd1VIM2hUOVJUdytPSmFrQXNraFJyM05CKytF?=
 =?utf-8?B?aUI5NGFUS1paaWIzalVYZDY4NnlKYXRPUG1IYkJoU0NlTVpkMDA0TTFxSE51?=
 =?utf-8?B?S3lhRU5kMVJNQUlOeUR1eDBlVXBBbkVudldHREs5Tk5oQTV5M2hnL0JUVVh0?=
 =?utf-8?B?cFAvVG5NVk9vYmhnUlEyMVYrRmJoRXVoYjdHN3FNcXhaU3pGZW5idDdHMlc3?=
 =?utf-8?B?ZVpNYTV3aUVBSUQ3LzNGd0w4STlOc1hYa3pCaHB0RVc2aWlIaXkvR0tDMi9Q?=
 =?utf-8?Q?JdCKS8VztuJcFUuasEi+0ylIu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b9e383-bc36-4996-a5e1-08da8799696a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 19:30:19.4221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dTnMphV30HdkJmloyznp7kmx/bhtfnv/CQChQBDFZC+HryuNPp+yKGEVlnHoTj1vH+fdx7PlXbZ8rOmJaOr1+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB3225
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: XCp9gQu-1WKv3l6jB-7Smsyd-eeiYwox
X-Proofpoint-GUID: XCp9gQu-1WKv3l6jB-7Smsyd-eeiYwox
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260078
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gVGh1cnNkYXksIEF1Z3VzdCAyNSwgMjAyMiA2OjIxIEFNLCBKdXN0aW4gSGUgd3JvdGU6DQo+
ID4gPiBAQCAtNTY2LDMgKzU0OSwzNSBAQCB2b2lkIGdoZXNfZWRhY191bnJlZ2lzdGVyKHN0cnVj
dCBnaGVzICpnaGVzKQ0KPiA+ID4gIHVubG9jazoNCj4gPiA+ICAJbXV0ZXhfdW5sb2NrKCZnaGVz
X3JlZ19tdXRleCk7DQo+ID4gPiAgfQ0KPiA+ID4gKw0KPiA+ID4gK3N0YXRpYyBpbnQgX19pbml0
IGdoZXNfZWRhY19pbml0KHZvaWQpIHsNCj4gPiA+ICsJc3RydWN0IGdoZXMgKmcsICpnX3RtcDsN
Cj4gPiA+ICsNCj4gPiA+ICsJaWYgKCFJU19FTkFCTEVEKENPTkZJR19YODYpKQ0KPiA+ID4gKwkJ
Zm9yY2VfbG9hZCA9IHRydWU7DQo+ID4NCj4gPiBObywgdGhpcyBpcyBub3QgaG93IHRoaXMgd29y
a3MuDQo+ID4NCj4gPiA+ICsJZ2hlc19kZXZzID0gZ2hlc19nZXRfZGV2aWNlcyhmb3JjZV9sb2Fk
KTsNCj4gPiA+ICsJaWYgKCFnaGVzX2RldnMpDQo+ID4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4g
Pg0KPiA+IFlvdSBzaW1wbHkgbmVlZCB0byBjaGVjayBmb3JjZV9sb2FkIGhlcmUuDQo+ID4NCj4g
DQo+IE9rYXksIGhlbmNlIHNob3VsZCBJIGV4cG9ydCB0aGUgKmdoZXNfZGV2cyogaW4gZ2hlcz8N
Cg0KSXQgZG9lcyBub3QgbWF0dGVyLiAgVGhpcyBzZXJpZXMgdGhlbiBtb3ZlcyB0aGUgZm9yY2Vf
bG9hZCBjaGVjaw0KdG8gZ2hlc19lZGFjX3ByZWZlcnJlZCgpLiAgSXQgaXMgY29uZnVzaW5nIGZv
ciByZXZpZXdlcnMuLi4NClBsZWFzZSBkaXZpZGUgcGF0Y2hlcyBiYXNlZCBvbiB0aGUgZmluYWwg
ZGVzaWduLiANCg0KVG9zaGkNCg0KIA0K
