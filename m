Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE3559A696
	for <lists+linux-efi@lfdr.de>; Fri, 19 Aug 2022 21:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351517AbiHSTiH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Aug 2022 15:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351516AbiHSTiF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Aug 2022 15:38:05 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25C711233C;
        Fri, 19 Aug 2022 12:38:04 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JJaj7i006153;
        Fri, 19 Aug 2022 19:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=Z14qp+QW9Tdq4XHkcAuA2glfC4kd6dCL5rJtKjxmgpU=;
 b=KxwCnAbSBvF6390SmanARHmG+aPfc8htt62c5LA3eFs6nOk44KzBsmJsTvEJZwEUWA0e
 UGt4P1Hrm1Y0cm6VqwjkeiYFl0veiOrk/YheKoBI0gByb0TSm8q/UxTdhrlUDFahPvhy
 bpRbWbLJNJK7+VkBq4k008wx8UetzbkX8DSsCPOEO0ac+fQgsAgOtlSWeqiHLY0+CM7X
 IOEVs6/j0n2pYARMYeGyTJT52aeDGSxUh/ggFyVH231J8+teVnuez9cYMdmeNutiJt+7
 h+DUDjigpNJMCUROVxW4STcbcDXPM1cPhMvvSN4XsUsqdXNuwqt0YKtYF3Za3FfCPGob Ag== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j2gu2003m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 19:37:22 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 40A4CD2E2;
        Fri, 19 Aug 2022 19:37:21 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 19 Aug 2022 07:37:21 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 19 Aug 2022 07:37:20 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 19 Aug 2022 07:37:20 -1200
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 19 Aug 2022 07:37:20 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/ZlXZI8UhTNRI+7fDqgBlJLhK3PYfRctraBqgBIrGMifzaIuX01PEMKNE5DsFAUY6IDUSQE7xbfXViK7Fn6pD8N5gU2DWRMh3zwLQNp6gzcPq/XhmCfyil+01u31rgTBgd3K4yH6XWQ7XB2G7I7zYVme3Wrii/IaPtUNsYyToqNVgXYWajmNc5ZAgWpDv7kUnV5KJxSkbttpYk4BwoahxF7hEQY1CvgYb2QZOO8pihUd1UH2GiojMzLSqWat04FRkuI6aejZDKAn84NFbEgeZVZ650w0kvZQP+t2G9lO42xjNZ/E2Kolub+xYaz0EzHrJwl+tGAh8CvCa8dxQ/1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z14qp+QW9Tdq4XHkcAuA2glfC4kd6dCL5rJtKjxmgpU=;
 b=fQyXsGW4rU2AEMtif95YdHXycoDA79vq0x8aDlZVcRgAaf//YAwYQPoP64qO4zV3ISJvEWf451lPmLDh98F7+YYwx7uWtaXSDHmqhNjLni4Oqw3df8AlIRFY0PpmOebQo75Ut7zw2w9J3swoqqWz1zy3648PtXhAMfzVbeDaZlkITxleut6fVnWKdVw5yunzwO4f3D+Rj7KQifyAwXKH7mXpU2UkfrlN8Djd3wZ+ZFfzbYAgndnItdDj3Mercpev2/yeHn5jvjnGQnNq0p/S7iuZlUoZj+HKUl7BUEhf4EakTb4USHSaWx954KDkj+dCOSowq0qaTszuxvKOEXvx1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4c::19) by
 DM4PR84MB1973.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.18; Fri, 19 Aug 2022 19:37:18 +0000
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6]) by DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6%5]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 19:37:18 +0000
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
Thread-Index: AQHYskazgdaGLeNebEWQzyv29780RK21ZjbQgACj04CAAE7iUIAANdmAgAADCCCAAAKzAIAAAGBAgAALBwCAAAFVQA==
Date:   Fri, 19 Aug 2022 19:37:18 +0000
Message-ID: <DM4PR84MB18530617E40AEC74145CD788826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220817143458.335938-1-justin.he@arm.com>
 <20220817143458.335938-6-justin.he@arm.com>
 <DM4PR84MB18538A56870A280CDC4637A7826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
 <DBBPR08MB453891E87563F1BBE291248AF76C9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <DM4PR84MB1853B213F2F45E495D9D6446826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
 <Yv/Wm/Zf0kdGgT33@zn.tnic>
 <DM4PR84MB185306C2C0DE95FF408173BA826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
 <Yv/batVmSf7PDRcL@zn.tnic>
 <DM4PR84MB185311667EA26C06348F6074826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
 <Yv/k+kcj6rRNRzkm@zn.tnic>
In-Reply-To: <Yv/k+kcj6rRNRzkm@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b06ea7a8-6638-44f3-e12d-08da821a3a69
x-ms-traffictypediagnostic: DM4PR84MB1973:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ynp3AnrKWTcOA383Bj9kNn1CtJx6uLhkuYhvcPspSMrSxk1gM9rY0OdddtQzQxzw+DRqbcwQ/MF6VTqLECREyozztpoGuHvcMhslxrnI0zGixcyqFXFN8PaFe/vN+7I+qOUKqRzTBx/745/GgUSxxft9kZVwKsVhIgh7dCHZUhrtHEvJveIxLVobtGgryIhzPDUOWyKsPVfPTml8X3mDJ65rz6TiOzOalwfc7yWGtuhL9qWGbVF5okTRDmsSMSKj/BR0kAV+/TbFw7eqI0IUqlZPdaQiofqoAjqnZEdJh8wrE42NAcMuXPkRG7+8uLh/s2/MaR5VW6YMUEBIS3FFDp+w8IS/5ygm2xjMuM0tSR3Oz+DvdDcxxz6fBoyl72bx07X14N3pTfcZMc3YsQDH/cZLWKIHcBp4bvxrvgOAHDn3vosxadmHnwEUMdJ56Tc+QxqKrAiqoaSmZXjcS0Prnh7givP59Rr+uOXOQ09Uianhs4YxCRWmTVTKcFP+E7NA9anC+ozKvz0TL6xTXcS3/sWCnqjCgGGORi3AoB+kW4etSWu5gZadMH+ZxbKdY466XaxK3zMVv06SkEVLecEMpwWLufYr5NvmQOw2H8vAQmbIQjJ2aW61VtwUrfHOeDIzsuV/9jndC9yxJhPkWDjxUIuqkMOD5GZ4Kyji5yi6JKxUuU2a7o8kck5UJGkVv2cT27hJoKfWrpM6GpoITucE5Q9HzwlPQznxcWlKhRw9dLgvU9yffw4FGT+xOMi0I63jGEyopc1Nhv17fT0JJfnoBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(396003)(346002)(376002)(76116006)(7696005)(6506007)(71200400001)(53546011)(5660300002)(52536014)(186003)(558084003)(66446008)(33656002)(66556008)(66476007)(4326008)(86362001)(64756008)(66946007)(26005)(9686003)(8676002)(55016003)(2906002)(82960400001)(38070700005)(83380400001)(7416002)(41300700001)(54906003)(6916009)(8936002)(122000001)(316002)(478600001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlhYb25yWUhkZWVsQkZaNUx5MjJucUNGY2tGQjFUZWl5VUlxeTNnZnlOVkxO?=
 =?utf-8?B?WmRCbWRRejVqZ2xubElvZ1FUWEEvSmlzNXZ5T3BOM2hqMXdmMW5HUDdVNXF5?=
 =?utf-8?B?aUNzcDlOQ25kNDlCUUJNMnEveWFaQW5NbEQyQXJ2QTFYdFZ3a292eUdmZGMw?=
 =?utf-8?B?WE45OEUrdzFJRjdCR1FSamZDelpyZzZuTzFqZEJpeHJNVzhVRnpLODg1Q3Ar?=
 =?utf-8?B?QTZiSlFiUXNiYnlHZTRZOHA4TSt4VVZzekw2OU5Kc0FoQ0VnRzFJQUZUSHRV?=
 =?utf-8?B?cUd3dDhaTzVGZ3F2cE5wRHpwaXR4WktTYU9za0RLMXJlWFAwb1J4VndpaERC?=
 =?utf-8?B?aWVqVUk0aFpBblJwNW5qV0JmSnBmS240cWxNQy9xSzFsOEhmRFRXeEprbDg0?=
 =?utf-8?B?b2R5YmMrVVAxNlV1QkJ2dnNqMjNTczF2NUljRytLRzVaWDgySWlQck5zeTd2?=
 =?utf-8?B?bGZjeVRXejhUY1R6S0tKY21wdEpDYlJtTFFLMkJ6akgyWDhpaFhZWHJ6dGRW?=
 =?utf-8?B?MmV0NDkzRitHTzVHR21BeDhpbmhwLzZXRDVjSE03ZEttWUppUWhhMXNGN2p2?=
 =?utf-8?B?YW11VkhhV055RnM3bXBMVFplKzV5MVVrTWtseFduZGFRWWFKV040ZmprT09u?=
 =?utf-8?B?eVJOZjk4SEdRaFJ2cUxxVU9NcEhzdHoxcFYxOTg4amhpekYzRDRtRW1RdldS?=
 =?utf-8?B?VG9ZQkZDWkVOV3k5VTJIRDY0ak1yY05nSUV5TkFaR284cUpoanlnRGpzS2lN?=
 =?utf-8?B?R0ZOOEZUTDF2ZGU1TXU0ZkdMWnJmMVVLTmhIRlNweXJuQlRsaWZHOTl4a0NX?=
 =?utf-8?B?VkhCR1M5Z2pCTi80MHBjTWZJSXZKd2ZhUW5pck1PSmpNY3dBRkNmUGlaQS9I?=
 =?utf-8?B?ODVYMTROZFRlYW01amE3TnZNUjRHQTRMVkNNdlo3WEZIVEFBYWZZYVVKTVNa?=
 =?utf-8?B?aTFldVZueE9NOUQ4bEE0bVhRQjRUbC9ZRU9ra1hPRUZBa2hrRG1oUnl3cDhS?=
 =?utf-8?B?cVhJTUh0TU1VZ3M4RUhkNEpoUVY5OHFlRlBYakxWNmhqR1hGdkwyMkttWXpk?=
 =?utf-8?B?bWxNZHVjRlkzeXVRdkJVTmZLQ2Y1QmtrZGZ2Z1UvTTc3UWtxWHFiNlMvVEdE?=
 =?utf-8?B?U09FaTRjTHhqelpLeS9lTkZaZEZCMnN2dkUwUmNiQTJ1cGJ3dXRKcnMwY1Vq?=
 =?utf-8?B?OVNHR2cxWTBTOGVUQXAzODM4OGJETUlyWmFucVlWYWtzRCtCaEkrQktuQWd6?=
 =?utf-8?B?ZTN3Y1BhZjRUZHJzTk9CRE5GUzg4dERzaGdHdXcybW9jYXJxcGhmeGFHVUVa?=
 =?utf-8?B?WGd2TE9oQmpzemJqY0VDL0JoeGNqUkNvK3dhWGJsQzloUE9vYlMwRDFoR1NF?=
 =?utf-8?B?VXZDZDU2TFY0MXgzQTZHVGNqQ3lPWXk1Q2ZQVWw0L2tYN1g2bTB4RUVZRnkz?=
 =?utf-8?B?clMvVWFOckUzQjkrWlB5YitFclkwTXMvV3hpcFdkNTVCbDZ5Q0k1N1VsQ2tR?=
 =?utf-8?B?QjZBNmtETTRKZHNxSFo3YTd6VHNoZVNGV3F3NmtuWURubUNKYUFsY0dxT0xv?=
 =?utf-8?B?N0t3R01QcU1pTmI3Nm13SDNVQ0ovdkpFUWxISDVqV3NoN3ZQb0s3cFlzdW1P?=
 =?utf-8?B?Yk5jaDQ3SDA3ZmRkQXJvMmYrOG5JOWpUNFFVcDgwU29kUGZiTGVHU3c2MTQv?=
 =?utf-8?B?NnhWTnZ2c2lzQ29MemhKblppMmE4MzZ1cHBEdHgxZXJjWmhacDZ0Z2gwWDRN?=
 =?utf-8?B?L0F3SnpzY0tyZmxWYmVNZkpiaHpsY0Nnc2F4LzBWaUJYYk9yU3FtZVB4bG5x?=
 =?utf-8?B?L3FQMXJQU3Y5djdPTTdnSTEzU3F4Z2g2U1pVKzdqZTFqd051WHZleWZSbWhV?=
 =?utf-8?B?U1ZhL2dQZXg5cjlrcnl0Q3E5dWdTb2FiSGpLKzUvWGpsUzJ2RkZWRG54Vmo2?=
 =?utf-8?B?N2dLUW9CVzBTK0w4NE9CQWpUd0tJWDA5dzdhQjlwYnYyWkJzUXVpSlBWcFkx?=
 =?utf-8?B?TjRmNHBxWWJxZDl4d1FaSFkvcTBveU5vZDREeEl0VnBUbW0yRTJjSWxEd2Nq?=
 =?utf-8?B?enZwYUhrR21lMFZIZHE2UGExTnEzRVlXc1YyZElsVWRrUFdNZ2toZkxMcS9t?=
 =?utf-8?Q?6cy5X/Nv5/oKrbBnFVKwPhdzS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b06ea7a8-6638-44f3-e12d-08da821a3a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 19:37:18.6811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ym/Flz8I392R+agNQWG7OPba18gm491Vc2xFs46zCDli3UqB3uBhEfzjVKBvewS1F47MvO4MMoVcprQxz1NG0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1973
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: vtXnBXPseQBpwj3w4mG9NsUGAYKkFkZ6
X-Proofpoint-ORIG-GUID: vtXnBXPseQBpwj3w4mG9NsUGAYKkFkZ6
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_10,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 mlxlogscore=694 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gRnJpZGF5LCBBdWd1c3QgMTksIDIwMjIgMTozMSBQTSwgQm9yaXNsYXYgUGV0a292IHdyb3Rl
Og0KPiA+IFdoZW4gdGhlIHN5c3RlbSBkb2VzIG5vdCBpbXBsZW1lbnQgQUNQSSBHSEVTIHRhYmxl
LA0KPiA+IHdoaWNoIEkgc3VwcG9zZSBpcyBtb3N0IG9mIHRoZSBjYXNlIG9uIEFSTS4NCj4gDQo+
IFRoYXQgc2hvdWxkIGJlIGRldGVjdGVkIGluIGdoZXNfZ2V0X2RldmljZXMoKSAtIGp1c3QgbGlr
ZSBvbiB4ODYuDQoNCkFncmVlZC4gIEFuZCB0aGF0IGlzIHRoZSBjaGVjayB0byBnaGVzX3ByZXNl
bnQgZmxhZy4uLg0KDQpUb3NoaQ0K
