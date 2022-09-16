Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA47D5BA73C
	for <lists+linux-efi@lfdr.de>; Fri, 16 Sep 2022 09:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiIPHKr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Sep 2022 03:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIPHK2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Sep 2022 03:10:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFDC56BA4;
        Fri, 16 Sep 2022 00:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663312196; x=1694848196;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c+mtVNdws+/ZnMaT3OgkskXygFibV/xKHJwgKjBYq8E=;
  b=tmUac+f6Bw/+aHORlZggq53b2XQmBaRMMfZMa26MynhVTppv7BwKyVbe
   Zpl+s/RuTmzPp6zM/MRjojX/7Ng5y0l2bEv8CfRnIWqiWr99n9qHChiFE
   0rgB1aVQ0AahkaE4KgHQD7PvallATL7+RIHszPAhj2A3YZ3oRLhwWbgnh
   ZpYEWMRPLtqfi1WJ9vbMid5i4gpncXZ3TG2AJldV5KtfDcZnFKvUmKE3W
   aOhKW/aaBxXDLlXWWVLJwHOSzsGc0GctOcCC9mQEjKasyLvpeRb5w2OCY
   HU+dE++uK5XjJP6zIX5T6L2c9HcrZyATdcICqhGq70qw5r0SPFLVneR0K
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="113971399"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2022 00:09:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 16 Sep 2022 00:09:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 16 Sep 2022 00:09:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7Xm8QdH0XflaoG+dZY5LV4F7hRfRF62geAFCe2ZyNL7u0DAbe/11W8KUDFJ55/18UAdB3ZK1lGDXsNC6yTGY47Ult48FcteIUY/MjEKU+RmBEk4QzG4OsMlCqEkGTzoiZRBgmHq8048OLRqcB2WmOMHgT4VfCJEFmxOUozFc9M5ztGULEXCCLduFnklDdWRdSdOQWkIY8aVfGY4RW63kSqRb0jmStmaRQsBfRBbG3IriZCRKlEgBqg7bB/JU5FTxEJ8MEW4SyeYC315tcASmOyTDY2V1Korvg5/ov/cmIdX2uf8qlzAjxgpxw550+5EF3EXl04uJSlFVIzP7uFtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+mtVNdws+/ZnMaT3OgkskXygFibV/xKHJwgKjBYq8E=;
 b=BWHFcVCFng/nJcB2qS1DbabfbCtL6y3rwGX6GRzBDjumJsaP40YvX4v7ypeVhTaZ70/yll9zQp+vIRh0Lghu4lDC7kMc6lito4R1VZCw0JWjLKD34SfJzSDPEzD85Q/uvr//smUV/Vxc25Ev4GEcUWsztB36elwsyC56CXW/g5WUipsfnvOHqGFCYc6lliFI0Aje3zjtnFRgQCFKdMJPbbRrjiQOu0CeOZH6HGDjrNACtafu/InnJKsdEdiT99KI8BMe79LjriMEdX4tVlgztrJEYHQOTvBKBad4yzGhEAx34qgrGbtF8AgTyYdAyG0LIVf2SRdBpY7e2foOGQ0Yew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+mtVNdws+/ZnMaT3OgkskXygFibV/xKHJwgKjBYq8E=;
 b=XjKguHjfWSjDc3owqtLLqLJe7W1TZe2A2sOecj6PT38Jo2wwzUsrggGd3HL+ApWse0DjGlp+WOL5lPfWu3k/bU9ddqcsdykFBLqbVog5YitqA2SL3DP/toU8MWXOvfcHI26QYj/wbYp8xJrV/TmFsY97RWRxb7x/XMmU6uDXl1Y=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by SN7PR11MB6850.namprd11.prod.outlook.com (2603:10b6:806:2a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 07:09:48 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::b5a8:a5c9:beb5:70b0]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::b5a8:a5c9:beb5:70b0%4]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 07:09:48 +0000
From:   <Conor.Dooley@microchip.com>
To:     <ardb@kernel.org>, <linux-efi@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <James.Bottomley@HansenPartnership.com>, <mjg59@srcf.ucam.org>,
        <pjones@redhat.com>, <ilias.apalodimas@linaro.org>,
        <heinrich.schuchardt@canonical.com>, <takahiro.akashi@linaro.org>,
        <palmer@dabbelt.com>, <atishp@atishpatra.org>, <arnd@arndb.de>,
        <chenhuacai@loongson.cn>, <xry111@xry111.site>,
        <lennart@poettering.net>, <jeremy.linton@arm.com>,
        <will@kernel.org>, <catalin.marinas@arm.com>
Subject: Re: [PATCH v5 7/8] riscv: efi: enable generic EFI compressed boot
Thread-Topic: [PATCH v5 7/8] riscv: efi: enable generic EFI compressed boot
Thread-Index: AQHYxO02VjiK1nlBsE+5Q/rRFO2jWq3hrKwA
Date:   Fri, 16 Sep 2022 07:09:48 +0000
Message-ID: <13de0332-df33-f13c-bed8-334b0cb84214@microchip.com>
References: <20220910081152.2238369-1-ardb@kernel.org>
 <20220910081152.2238369-8-ardb@kernel.org>
In-Reply-To: <20220910081152.2238369-8-ardb@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5160:EE_|SN7PR11MB6850:EE_
x-ms-office365-filtering-correlation-id: acc02749-cc1e-4fed-f350-08da97b27145
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k9qDEMr6J0c9UGPv/LPF09+0cPKCgmXKJobHypLtP2GRInvn9is9cIQv5JnsH/UblPhIeBCHAlZ4dUUsYN9CTfdGlVqdxRbmxfXx7dTNUxYKFGEn+isRVfnGJsEhbfmeRBuWDWydU4+5FtR8Qy2DeQsTgP4we8vFAiGlLbhI5t5Z4/080oSeTW7KyY13Yf8vKm/SMz5VTNs7q01wuZhorvKtKHdcC5agzVmlpGjNc6SOQYatU650c5SqV64CI+v6RIUsv4w03AfQ6noLpwBQGpQ39BTxHi5GxJOrVpMxVat/pqO9TpPj52xOO+/mOckifkx7lmHqAoPc3YDfCzMsze8/1xf7ycuyonfwXQNTdqWFAojMEFUKI9ds4bGOC8u4mHSVw9ENXkrYny93iWozJ+rTeAijPYJkZPDAXYA+v89X6yXFktvW1X8PoIul1YirxFzLrp+u9dE0kLrTGkYffRNHjG5xCmWqttXRFx5SOYHKaa047/6qxmuSr0AK4AjGUePJXukVb4XZ0uK0hR0JblWj+mFb5oDhf0g5fhPUIFQ97Ui8vlJOkjOkrpAW5oOeUOLG12ZkJ8xAJGPYnrhZ3dzAT9ixvQ7iL+QTC8PVXjIcmrOCtw6OXDmCRphDRbBZALttvud6CSn3vAilhlxAPY9I0ZTF+RwvJHY0q0m23DCgeSkmv0ELDdyDvI2Kc5PUXqWPBAeg2Q2C1hSC4E/6emOeB2Ysw/LvshFyJvICBXuCbHQWcddvLaPHmmybTl7/mL8EcJqcmi/3ivJGu6iUEfMLg/7tILE7VSGfdBcpCvTBqC3yC7SDYDpChFRFIY1A1XUSge8ChtqxWpaNWSRsKumzjqjmPAlLRKUntaeHvFI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199015)(91956017)(41300700001)(83380400001)(4326008)(6486002)(110136005)(5660300002)(64756008)(66446008)(7416002)(86362001)(38070700005)(71200400001)(76116006)(8936002)(6512007)(2616005)(66946007)(2906002)(316002)(31696002)(66476007)(54906003)(66556008)(8676002)(38100700002)(122000001)(36756003)(186003)(53546011)(6506007)(478600001)(26005)(31686004)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkorbTI4cE8rbWVrMldpQ1d2eDJqK3l1YytZbU5tdGNicko3S3E2YTZtV1Yr?=
 =?utf-8?B?bTlncmdwcS9HclZESUZFZWcwOFRkN1B6aXhJSXQ5S3BHQ0g3M1VMQ3BiTnRK?=
 =?utf-8?B?c1VpOHNZTHhTbHpBRHNwS2tpRDY3Z3Y5dXRTZmN2Z2NBL09wZGNEWFYyQ2dZ?=
 =?utf-8?B?MDRyZ3BDbDZ1cTVTaENGNHhIeWx5ZEVqSGFyR3ZMMHYrVyt5bGlkV0lBTmhY?=
 =?utf-8?B?V2pMZjQ4eVA2RU1jaG9EbXJIRENiUUQrbkJFbE1jbFhoRURock9USTRjdUFk?=
 =?utf-8?B?ZEZMT0lZZHFZS1dLSWJxK1VYQllaRndhUEV1SlkzcGs1emJZbWtySTQ0bFJY?=
 =?utf-8?B?WWlBeTQ4bVBYU0FrY21DWTJKUlJIS0I0cEFuNHNtUWpEL3ovcGtrbStIODZp?=
 =?utf-8?B?NnRrMEgybnpKRzA4VVdhMXROejFkVnJjYlBzT3J6UFl2c2hRaUhyYlJUOW9T?=
 =?utf-8?B?UFBOQlUvVEkwRnNUSUFWcm1oMkdKWllzaUxqdjRIZUpiK0NnazMxeUZPOWRF?=
 =?utf-8?B?WWV0N0h0WGNJNjdUK2M4WTJqZnlXUEd5NjJ0dWRqUmx0cUh3aCtVQjlONTVC?=
 =?utf-8?B?ak5wOHhPRWFabUJ4NTREWW5rWjMrd2krWTBBQXRIZkRHWlNHdURuQ2RZVXFr?=
 =?utf-8?B?VHJaSGhPSW1ieUJxTEFLQmp1U0tVUG13NThLTGJHeGlEdTQ5cXY0ZHdkZkdi?=
 =?utf-8?B?QkZ1Z2JLeGpNNEMwOWVSS1BCRkZlRGJrdEE5NXBPSXMwT0lJbmNtOWc2dC96?=
 =?utf-8?B?S3VPL1FpaElXRHJHNEVNb2VzbVNKTWtUYitPRnA2U2xTdlI2Qk8reVdJRWpm?=
 =?utf-8?B?cGNLZGVSbEw1QUd5RTllTUZqWlRFUGtrYWw5TFkrOStycnFpMkFHZUhyZ0pS?=
 =?utf-8?B?SGFoUWlIaGd5RFpiM3AxQ05WL0xoNnRFaENRakxBZ3Z1MGJ3MXRpTUNxSWg3?=
 =?utf-8?B?aWdpYmp1M0VFaU9iUXZjMHd2eXdWd2VZU1BUaWU3RlQ0NXRaVXc1VVJ6WDlt?=
 =?utf-8?B?dHNHaUdac000ZHFhNW9KeXlwcTQxMGgwWkxXQWlBSXRqR1N3SUFFVG9VOE1t?=
 =?utf-8?B?bE1Kd0NabGlIWjNDSzhMTk02SEdzWWlrWU1ZYUpCcFRIZWZTV2p5dXdzbkEv?=
 =?utf-8?B?TlJzWWIvWlorVFN2aTBOWVY5T1JURFVTWE1zeWpua25QckhyY3ZIWEhTVGFM?=
 =?utf-8?B?WS9ncHhadkk2aHQyWmEzemMwK0IybTdnQmY1YUpJN28weVRCNWtmTk9pSWhV?=
 =?utf-8?B?WDlFOEVJT0JZRmFYQ3RkYVkzVTh0Rkp0cEltL1UxcGlPNU90Z1poL0p5Vzhq?=
 =?utf-8?B?cERvcXBRMVd6Y2NLWE83RnNPM3FXVTFwd1g2Q2hFYkQva3RHL00renBEWHhj?=
 =?utf-8?B?eEFYSnhoUWljU3prUktBRnQyMGNidmMweDJsNkROb0UrM2lhdHozZ082aXk2?=
 =?utf-8?B?bGJNWnF3RHpXV2JKYlZLemFDNFNrak4wc1J3Y1hSY3kyTW1iYWVSVEpiN3U5?=
 =?utf-8?B?aDNQQitKekxDUkUvMllvU2tTcllPQnJRalN0UHMxR2V3V296OVFrY0xYS0pv?=
 =?utf-8?B?NHJJS3pQeTNldXY2ZkJJNzRZQmZDSks0YzdjV0E2Q2FKeDIrSjl4NVE3UUEx?=
 =?utf-8?B?aElaM2Q5T0FMcVZWRXgzQTNYSm44d1RiTEpSa3BpN2J2V2ozVCs4TGEwMk5u?=
 =?utf-8?B?TTZpY1RyR25kV3A1UzAzNEdReXFJU0NudFBCV0RlTlZyOUQxa00yeWpvUHhh?=
 =?utf-8?B?OER0am8xa3RHeU1McCtnbFY0RW1KYUxNVHhMdExxUUlncEt0N2o5Yi9XTVRy?=
 =?utf-8?B?T2pXQ2c5UC91R0lPN3dFSHJRcmJYckVqRzZQUng3YlFUa2hIeTRoTWk2b1I0?=
 =?utf-8?B?dDBOa0lDRExienBRTWJXd1YxY0pKMVNtYVpTTkg3dUF3T05aNmpHaCtZam5a?=
 =?utf-8?B?c0hLcXhEOGVYdEovMVhiVkh6aTYxY1U0dU9BQk1jamdkVjRBbUVvbFZWZy9m?=
 =?utf-8?B?RXlDdExHdjZ5cG0vNEd2UFA0a0luSmpZaXA0NnBJUjdxbXZFWTYwTCtvYStF?=
 =?utf-8?B?ejQrMTlQNUp5MVVsVWllQXRKZVRMZWhRdUJxK1FZcjl3SGdLN2VOS2kyMU5n?=
 =?utf-8?Q?sH+Qo7K3OpBhtqwxu6rEtfO1o?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE08047F3746A343A1BCA4FCF78C45C6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc02749-cc1e-4fed-f350-08da97b27145
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 07:09:48.6416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ChRyRPO26/kfM9sOON4AVCFtqy9rveHBgBEbm9CGsjZm3kaBa5vvbT2ePGD3Pl0L/dDf0KLFSJ5Sk8gssHprF0yqvluNQmZ0V+4LylKCyTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6850
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gMTAvMDkvMjAyMiAwOToxMSwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gV2lyZSB1cCB0aGUgZ2VuZXJpYyBFRkkgemJv
b3Qgc3VwcG9ydCBmb3IgUklTQy1WLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQXJkIEJpZXNoZXV2
ZWwgPGFyZGJAa2VybmVsLm9yZz4NCg0KQXMgcHJvbWlzZWQ6DQpUZXN0ZWQtYnk6IENvbm9yIERv
b2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICAgYXJjaC9yaXNj
di9NYWtlZmlsZSAgICAgICAgfCA2ICsrKysrLQ0KPiAgIGFyY2gvcmlzY3YvYm9vdC8uZ2l0aWdu
b3JlIHwgMSArDQo+ICAgYXJjaC9yaXNjdi9ib290L01ha2VmaWxlICAgfCA2ICsrKysrKw0KPiAg
IDMgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvTWFrZWZpbGUgYi9hcmNoL3Jpc2N2L01ha2VmaWxlDQo+
IGluZGV4IDNmYThlZjMzNjgyMi4uZDYzMjk1ZTIxMzczIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jp
c2N2L01ha2VmaWxlDQo+ICsrKyBiL2FyY2gvcmlzY3YvTWFrZWZpbGUNCj4gQEAgLTEzNiwxMCAr
MTM2LDE0IEBAIGlmbmVxICgkKENPTkZJR19YSVBfS0VSTkVMKSx5KQ0KPiAgIGlmZXEgKCQoQ09O
RklHX1JJU0NWX01fTU9ERSkkKENPTkZJR19TT0NfQ0FOQUFOKSx5eSkNCj4gICBLQlVJTERfSU1B
R0UgOj0gJChib290KS9sb2FkZXIuYmluDQo+ICAgZWxzZQ0KPiAraWZlcSAoJChDT05GSUdfRUZJ
X1pCT09UKSwpDQo+ICAgS0JVSUxEX0lNQUdFIDo9ICQoYm9vdCkvSW1hZ2UuZ3oNCj4gK2Vsc2UN
Cj4gK0tCVUlMRF9JTUFHRSA6PSAkKGJvb3QpL3ZtbGludXouZWZpDQo+ICtlbmRpZg0KPiAgIGVu
ZGlmDQo+ICAgZW5kaWYNCj4gLUJPT1RfVEFSR0VUUyA6PSBJbWFnZSBJbWFnZS5neiBsb2FkZXIg
bG9hZGVyLmJpbiB4aXBJbWFnZQ0KPiArQk9PVF9UQVJHRVRTIDo9IEltYWdlIEltYWdlLmd6IGxv
YWRlciBsb2FkZXIuYmluIHhpcEltYWdlIHZtbGludXouZWZpDQo+IA0KPiAgIGFsbDogICAkKG5v
dGRpciAkKEtCVUlMRF9JTUFHRSkpDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290
Ly5naXRpZ25vcmUgYi9hcmNoL3Jpc2N2L2Jvb3QvLmdpdGlnbm9yZQ0KPiBpbmRleCAwY2VhOWY3
ZmE5ZDUuLmUxYmM1MDdlOGNiMiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9ib290Ly5naXRp
Z25vcmUNCj4gKysrIGIvYXJjaC9yaXNjdi9ib290Ly5naXRpZ25vcmUNCj4gQEAgLTQsNCArNCw1
IEBAIEltYWdlLioNCj4gICBsb2FkZXINCj4gICBsb2FkZXIubGRzDQo+ICAgbG9hZGVyLmJpbg0K
PiArdm1saW51eioNCj4gICB4aXBJbWFnZQ0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290
L01ha2VmaWxlIGIvYXJjaC9yaXNjdi9ib290L01ha2VmaWxlDQo+IGluZGV4IGJlY2QwNjIxMDcx
Yy4uZDFhNDlhZGNiMWQ3IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3QvTWFrZWZpbGUN
Cj4gKysrIGIvYXJjaC9yaXNjdi9ib290L01ha2VmaWxlDQo+IEBAIC01OCwzICs1OCw5IEBAICQo
b2JqKS9JbWFnZS5sem86ICQob2JqKS9JbWFnZSBGT1JDRQ0KPiANCj4gICAkKG9iaikvbG9hZGVy
LmJpbjogJChvYmopL2xvYWRlciBGT1JDRQ0KPiAgICAgICAgICAkKGNhbGwgaWZfY2hhbmdlZCxv
Ympjb3B5KQ0KPiArDQo+ICtFRklfWkJPT1RfUEFZTE9BRCAgICAgIDo9IEltYWdlDQo+ICtFRklf
WkJPT1RfQkZEX1RBUkdFVCAgIDo9IGVsZiQoQklUUyktbGl0dGxlcmlzY3YNCj4gK0VGSV9aQk9P
VF9NQUNIX1RZUEUgICAgOj0gUklTQ1YkKEJJVFMpDQo+ICsNCj4gK2luY2x1ZGUgJChzcmN0cmVl
KS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL01ha2VmaWxlLnpib290DQo+IC0tDQo+IDIu
MzUuMQ0KPiANCg0K
