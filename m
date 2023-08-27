Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C3E789C99
	for <lists+linux-efi@lfdr.de>; Sun, 27 Aug 2023 11:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjH0J0N (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 27 Aug 2023 05:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjH0J0J (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 27 Aug 2023 05:26:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72528DA;
        Sun, 27 Aug 2023 02:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693128366; x=1724664366;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CLB98l5d14Xq1QQJ6A+X6NOacSEqJr4W2xdHdW10P/I=;
  b=gmp4aeUCvjZaroV4ch2IbIfiVZbjqmKnV91eiJjmvTSR34GohtGT2SP9
   vGNF+PfoHd9Xd3/d+IJsNKsZ1TWjMDRBxiHMCBB4koY7TDw93oagCnlBG
   CmtHb0juTcC7qVIPEZPohWWJ7GR0htc7msUVk5CBPjRaIyjQpzNTtxo/A
   SyDYUsrUyK7i5vyrNdXdmB4semXoIO5zjmn1WkGU/qKpWX+S9Hu2aPuOs
   Rde6pOKoMES4EdyOr1XxVRSBJyZf/RwFj/5y+DSeCoJntjgk6jfh7j+iA
   rqJcK728cQy0xyMil5A+I4BZl08pIEpMxLgTFt0pxt1JoDgCpoG7+x464
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="365134020"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="365134020"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 02:26:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="852485616"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="852485616"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2023 02:26:05 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 27 Aug 2023 02:26:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 27 Aug 2023 02:26:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 27 Aug 2023 02:26:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFWt7gaCtXmXMeObNqJEFYiM79AoO6+f7/J7yWU8NjXSIGh0Vm90qZjq0A01le9xNNGrJrzZ8tcMh7WqaHnHMaJcyrb3cBYPLBxfDQKTRGmlgreePA1kj10xfj6qsKIISzHhuymhFHZG6OWtaCRmYyAbaIAiEmqHT1+++Ihs+nKVpAB73gw/XqJMMCoFJGx8VLp8gdyaqiYbudEFrdoMxO47ryK4F6CcZr54HH6YSjcinRsAh8OqDT5YI2n8NC5B6xA0mtZcif0Nj7ce6ivwlwx0M4nqWRDmu3kMW978CF2VDk0R/1+AXx/C2xZDvty5p6IKOzd0SytWQ6VgCJ7Xjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLB98l5d14Xq1QQJ6A+X6NOacSEqJr4W2xdHdW10P/I=;
 b=IemtJFEv7F6nfOyrZv5a1rSm2SvVSDZhPdfbAll7sdwrDgzk3eaIf7B35zdqCWvVOC7AURjPPPvCQDjvUxxVmJErgpNz3hC6/EfbPS7WjsXuOzKcEMLkQqVWcmE3YsJhLLd/EAu/MNP0pttOEnvPdBuOpmfz7emcQ+vTAyh6U7N+lNyUKFThVIq3TwNTt/z8wxMRXiAvbuBfwg2guvaiyAOBPE0osmZ/wM0ACzJdN/TFMKgE+gDYkcFxXBRPOtn0HWFH63hcdc/HGJbSItxdBtyRNkcJqpDD8PAPz/5S/RjAWEXB4dSzs2w+jlv5q4ey5pp83en5AyZUMPug5Op9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 IA1PR11MB6538.namprd11.prod.outlook.com (2603:10b6:208:3a2::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.34; Sun, 27 Aug 2023 09:25:58 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531%3]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 09:25:58 +0000
From:   "Wang, Xiao W" <xiao.w.wang@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>
CC:     "Li, Haicheng" <haicheng.li@intel.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RISC-V: Optimize bitops with Zbb extension
Thread-Topic: [PATCH] RISC-V: Optimize bitops with Zbb extension
Thread-Index: AQHZyA83tlYFgJbtxEiuzFgm3vAb3a/dA3eAgAAJ0KCAIOt48A==
Date:   Sun, 27 Aug 2023 09:25:57 +0000
Message-ID: <DM8PR11MB575198187CB962EBE663B7F0B8E1A@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20230806024715.3061589-1-xiao.w.wang@intel.com>
 <CAMj1kXHicVpT7PDSB=BgYEuhBxgufHqd9X8ZCg19k0_U+rjvEg@mail.gmail.com>
 <DM8PR11MB5751DA69DEEAAC9B06623E0BB80FA@DM8PR11MB5751.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB5751DA69DEEAAC9B06623E0BB80FA@DM8PR11MB5751.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|IA1PR11MB6538:EE_
x-ms-office365-filtering-correlation-id: 848ebdca-f207-458b-86e1-08dba6df9f12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WTJ5our3RdR+Tm0cT4CDbmCxqdagXb1rfGRT8hMUQSZCOZVMTcpSraznOORAmSTMWIDq8FwRgT/I+aBnQd6xC6cerKhT8cJ2tGje4HvHmgkzYmP8jXiRzsKrkvFhvSQZG83C0q6fj6fHkE7epJ7oTwOzSyDfXIvbStdirlJx3ZRzrbtc/UIyAeeyeg7qY/04ZjnU4dPXuxOMWuh5k1DGY+BwvbOlL31DL++5A+id5Qd7YgG4aof0wrjTLWCG9PFZQmgNAjIAEKRS0PjELw5pp5yTojBjWSZo3FWLgGWkaDz73pdeFowvencDuaFK/+dQWfvQdueshD8yK05lA3TO2DJ5oVscz1mEzmQg8uWyQtjUfLRwgkuMn4h+9lfDRFwMioRgjTLnyLbSxQuu5gwUaj0dWghO71lIiUQZEfOWCA0QrMnRyihYKwnhPT9FumftK9wV1PzzGcSUJCzJz2Kt68A4WOt/QCwjRFPKHdb3vQwYvaeR3xBpp1lDVn2E7O9kDGHPp+nRZD0uO7sVMk0JCGpV+mu+7W1M2hDqjNgS2vOm7flu66D3XHayZmqUKELAkH9+onmQhcCzJMUv5FgdnHfVhvFv30TW1NS55S2xyG+Ml8LZWX/O0S1sKJMYnABW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(71200400001)(55016003)(53546011)(6506007)(7696005)(9686003)(110136005)(52536014)(33656002)(2906002)(86362001)(5660300002)(82960400001)(4326008)(38070700005)(54906003)(8676002)(8936002)(66556008)(66946007)(66446008)(64756008)(66476007)(41300700001)(76116006)(316002)(38100700002)(122000001)(478600001)(83380400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3AreDF2OWdtOExUZElId04xbENZSE5Eb0Y5aFdZNkVEbFora25IbGcwZEhx?=
 =?utf-8?B?RFBVc09CRmpXQVovL1pMeitSbUIyV2l2bkFHT2wzUkRYa2ZCZVpMYXdHK3I3?=
 =?utf-8?B?NE9YRk1NRHNoQXFpSWR3dGRtMUZwN0FaVTNvZVJqcTRxN2lXRitQQVBjdWxm?=
 =?utf-8?B?dEVBd2FLbnZWa0NSV3NGUVA5eStsWUt4bVNXTFk1NmxCcTlKWUpuNGN4NXZa?=
 =?utf-8?B?OTgyK1BxVThEZW4yMXNrU2VOaGNYWEl6UkdvWEhpTFNXb2VYSFJIYkozQklM?=
 =?utf-8?B?S29KVGJ6Yzdoc09ibHB2RUVBY0RqeUdFZURuSHJPcGxqaytsOXBTWXYweDM5?=
 =?utf-8?B?Nlg3WkZhdklHN21xT3dXOTJDTDg2RHF5YzZDZVZTS1ZRVlJpeUZSYUIrMzVU?=
 =?utf-8?B?OWZTUjNwQXVNeHdEQUtvS0VoTmdpQkxFUGN5bHN5bzFoeHB2Y3c4L21sWGhm?=
 =?utf-8?B?UWRTanNwUDhjdUlIYjVIWWN3SUV3bEN2QVFPQ1A5Q1V5emttZWtNWjVGK1Y3?=
 =?utf-8?B?NVkrWjZTU2pWRXpzT1J0SGxzQlFxOW1sTkkvakZSQVJLZDZFMFZTNFJDZ05i?=
 =?utf-8?B?dmlBNk5nZHFjdUFTY2JVeThXMWJSTGEzNjJDWldDdE5oV0pkbTZobDJoWm9h?=
 =?utf-8?B?M2xyL0hsMkVsdWdwcTVBbjhYUlRzSWhSc0t4YS9NR0RIT21CZ1Y1OGVQdnpt?=
 =?utf-8?B?RFBaOSszdUdRc1A0dVU2d3dDUnZ5RUxOL2tEc0dSV05ISnpSVUlvSkMrZ0p2?=
 =?utf-8?B?bE9MWUZWK2Y0ZFFIaVkxSUZsQUlUMTlaRTQ1Skw3UVR6YlJjM0Y1cHFTOHVo?=
 =?utf-8?B?L0ZYcDIzcDF4ZEhjdnBqcEhET3NORHlwZytkSWdTMG1GWm02Tk15TDBDYlBG?=
 =?utf-8?B?RVVNWGJaUGdVSFN2K1lTa3BINkdTNGdTMjNZT1BlaE5DRks2WUp0ZS9sZHd0?=
 =?utf-8?B?TzBLOFNlbmVEMHZaTlhnNGtSU2Yyczh5ODRCaGpyREF4RDdxUDJnbjAvd0Nj?=
 =?utf-8?B?RDBha0pZb2tKT3dvbkJGSWc4QlJmazNJdEc2ejIyT1ozRGRmSWpSL0FEWGRr?=
 =?utf-8?B?N0cyN2hubXJSdUhORFZkNCtTamxQc3ZndUd3T01hUUJEVW00Q21PeFpFQnZ0?=
 =?utf-8?B?TTBVNmx0U2k5UTlQdnRPOER1OVlPOFNsYVA1V2RRanUyYUZiRmpsZC9MSVps?=
 =?utf-8?B?STdZcjFGKzQyWTNrb3BCTXVtUTR5Q2Q0ZnhrT0txdm5PNFVvOWtkc0YxRWlP?=
 =?utf-8?B?MVkwcCtzNE5RNHhTUWR6T1d6K0ZlUlcxS2Iwb21kVlEyQ090dlBtU2RSb1Nt?=
 =?utf-8?B?QWNTL0FvR3pBekEvUWx5bjRCY0kxMmlZWTJMemtaYU1WL1BRbjFINGVIT2la?=
 =?utf-8?B?OTJsSWowTGw5R0E4WC9CRUp0SHFLeVdTd0ZoMHhwVW5raXhqZ21uWUhZeDdl?=
 =?utf-8?B?VnFhNVdIdk4veEs0NDF2TGpTVHphZUpobC85S1Vac0p4TlhNdHBmSTAvTGZN?=
 =?utf-8?B?YWIvTWl5VG0rUGEwdVVhV0hWNFZkNlpJd1hXZEhtZTlNc1lEellmaWxoVDgz?=
 =?utf-8?B?Y051dzRnbHBoV2pmbGtrejU0SExQZHBZblJVaXkrbU5FQnY4MWJVd29lejBY?=
 =?utf-8?B?NU03U2poWng4bXZwNWM2U0hYbGx2WDR5ekwrTm1DZFhaZm42VkFJWVQ4M2dO?=
 =?utf-8?B?RzduL3MwZWVNeUVNWEI4eUhzVGlBZlJPSUJhVnNoODhZLzJHM3RERks3VVJJ?=
 =?utf-8?B?ZVlWeDJ4ZkZhRmU4dHp1dVpCS25ZdDVLMWlSM1pOSzN0MGljSEFGZ1JxQzBr?=
 =?utf-8?B?ZUFZYTB5bGh0RTZFK25nQzJYaGEwaGdRR1FKY1VtY1I0Mm51Qy9Jci9KcGRm?=
 =?utf-8?B?YWs4YUxLOTdsc3JCTXQrWDVtbTN4aU1YdkxMYnFBWEN1enV0Rk40MGtvQzZh?=
 =?utf-8?B?V3MrV292T2RYM3FENUxmTDBrejY3RU9sNWx6MzlDK2RDYnRzS0UrZ3RPZHJS?=
 =?utf-8?B?TDBvVnBOOUF0djg2NVJwbnZxa3hHWmNHc280dmhqSFh1YmdmRTVtODAzOSto?=
 =?utf-8?B?ZWdPZDFWRDlrYnRONTZzQVJuZ1h0R2JhMkJLN2hPaDZ1aythV3J6YTRyTVgr?=
 =?utf-8?Q?cmz/PCE6A7jKSx7q1Ibqjho+d?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 848ebdca-f207-458b-86e1-08dba6df9f12
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2023 09:25:57.9159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e9nF250UP8DwSvKYIGJ2PADK0sgLp/XSuE+bWd7CqDPw2YAApxe0P8bwBoOlfAnM1Ejy6QV0xCtGBR3xLct3Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6538
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGksDQoNCkEgZ2VudGxlIHBpbmcuDQpBbnkgb3RoZXIgY29tbWVudHMgb3Igc3VnZ2VzdGlvbnMg
Zm9yIHRoaXMgcGF0Y2g/IE9yIG1heWJlIHdlIHdvdWxkIHJldmlldyBpdCBpbiB0aGUgTGludXgg
Ni43IGRldmVsb3BtZW50IGN5Y2xlPw0KDQpCUnMsDQpYaWFvDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogV2FuZywgWGlhbyBXDQo+IFNlbnQ6IFN1bmRheSwgQXVndXN0
IDYsIDIwMjMgNjoyNCBQTQ0KPiBUbzogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4N
Cj4gQ2M6IHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbTsgcGFsbWVyQGRhYmJlbHQuY29tOw0KPiBh
b3VAZWVjcy5iZXJrZWxleS5lZHU7IGFudXBAYnJhaW5mYXVsdC5vcmc7IExpLCBIYWljaGVuZw0K
PiA8aGFpY2hlbmcubGlAaW50ZWwuY29tPjsgbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgbGludXgtDQo+IGVmaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gUklTQy1WOiBPcHRpbWl6ZSBiaXRvcHMgd2l0
aCBaYmIgZXh0ZW5zaW9uDQo+IA0KPiBIaSwNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPiBGcm9tOiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPg0KPiA+IFNl
bnQ6IFN1bmRheSwgQXVndXN0IDYsIDIwMjMgNTozOSBQTQ0KPiA+IFRvOiBXYW5nLCBYaWFvIFcg
PHhpYW8udy53YW5nQGludGVsLmNvbT4NCj4gPiBDYzogcGF1bC53YWxtc2xleUBzaWZpdmUuY29t
OyBwYWxtZXJAZGFiYmVsdC5jb207DQo+ID4gYW91QGVlY3MuYmVya2VsZXkuZWR1OyBhbnVwQGJy
YWluZmF1bHQub3JnOyBMaSwgSGFpY2hlbmcNCj4gPiA8aGFpY2hlbmcubGlAaW50ZWwuY29tPjsg
bGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+ID4gZWZpQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIFJJU0MtVjogT3B0aW1pemUgYml0b3BzIHdpdGggWmJiIGV4dGVuc2lvbg0KPiA+DQo+
ID4gT24gU3VuLCA2IEF1ZyAyMDIzIGF0IDA0OjM5LCBYaWFvIFdhbmcgPHhpYW8udy53YW5nQGlu
dGVsLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gVGhpcyBwYXRjaCBsZXZlcmFnZXMgdGhlIGFs
dGVybmF0aXZlIG1lY2hhbmlzbSB0byBkeW5hbWljYWxseSBvcHRpbWl6ZQ0KPiA+ID4gYml0b3Bz
IChpbmNsdWRpbmcgX19mZnMsIF9fZmxzLCBmZnMsIGZscykgd2l0aCBaYmIgaW5zdHJ1Y3Rpb25z
LiBXaGVuDQo+ID4gPiBaYmIgZXh0IGlzIG5vdCBzdXBwb3J0ZWQgYnkgdGhlIHJ1bnRpbWUgQ1BV
LCBsZWdhY3kgaW1wbGVtZW50YXRpb24gaXMNCj4gPiA+IHVzZWQuIElmIFpiYiBpcyBzdXBwb3J0
ZWQsIHRoZW4gdGhlIG9wdGltaXplZCB2YXJpYW50cyB3aWxsIGJlIHNlbGVjdGVkDQo+ID4gPiB2
aWEgYWx0ZXJuYXRpdmUgcGF0Y2hpbmcuDQo+ID4gPg0KPiA+ID4gVGhlIGxlZ2FjeSBiaXRvcHMg
c3VwcG9ydCBpcyB0YWtlbiBmcm9tIHRoZSBnZW5lcmljIEMgaW1wbGVtZW50YXRpb24gYXMNCj4g
PiA+IGZhbGxiYWNrLg0KPiA+ID4NCj4gPiA+IElmIHRoZSBwYXJhbWV0ZXIgaXMgYSBidWlsZC10
aW1lIGNvbnN0YW50LCB3ZSBsZXZlcmFnZSBjb21waWxlciBidWlsdGluIHRvDQo+ID4gPiBjYWxj
dWxhdGUgdGhlIHJlc3VsdCBkaXJlY3RseSwgdGhpcyBhcHByb2FjaCBpcyBpbnNwaXJlZCBieSB4
ODYgYml0b3BzDQo+ID4gPiBpbXBsZW1lbnRhdGlvbi4NCj4gPiA+DQo+ID4gPiBFRkkgc3R1YiBy
dW5zIGJlZm9yZSB0aGUga2VybmVsLCBzbyBhbHRlcm5hdGl2ZSBtZWNoYW5pc20gc2hvdWxkIG5v
dCBiZQ0KPiA+ID4gdXNlZCB0aGVyZSwgdGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgbWFjcm8gRUZJ
X05PX0FMVEVSTkFUSVZFIGZvciB0aGlzDQo+ID4gPiBwdXJwb3NlLg0KPiA+ID4NCj4gPg0KPiA+
IFdoeT8gVGhlIHVucGF0Y2hlZCBzZXF1ZW5jZXMgd29yayBmaW5lLCBubz8NCj4gDQo+IEl0IHdv
cmtzLiBCdXQgdGhlcmUgd291bGQgYmUgYnVpbGQgd2FybmluZzogb3JwaGFuIHNlY3Rpb24gYC5p
bml0LmFsdGVybmF0aXZlJw0KPiBmcm9tIGAuL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIv
Z29wLnN0dWIubycgYmVpbmcgcGxhY2VkIGluIHNlY3Rpb24NCj4gYC5pbml0LmFsdGVybmF0aXZl
Jy4gQmVzaWRlcywgdy9vIHRoaXMgTUFDUk8sIHRoZSBvcHRpbWl6ZWQgdmFyaWFudCB3b3VsZA0K
PiBuZXZlciBiZSB1c2VkIGF0IHJ1bnRpbWUsIHNvIHRoaXMgcGF0Y2ggY2hvb3NlIHRvIGRpc2Fi
bGUgYWx0ZXJuYXRpdmUuDQo+IA0KPiBCUnMsDQo+IFhpYW8NCj4gDQo+ID4NCj4gPg0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogWGlhbyBXYW5nIDx4aWFvLncud2FuZ0BpbnRlbC5jb20+DQo+ID4gPiAt
LS0NCj4gPiA+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2JpdG9wcy5oICAgICAgIHwgMjY2DQo+
ICsrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gPiAgZHJpdmVycy9maXJtd2FyZS9lZmkv
bGlic3R1Yi9NYWtlZmlsZSB8ICAgMiArLQ0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjY0IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2Fy
Y2gvcmlzY3YvaW5jbHVkZS9hc20vYml0b3BzLmgNCj4gPiBiL2FyY2gvcmlzY3YvaW5jbHVkZS9h
c20vYml0b3BzLmgNCj4gPiA+IGluZGV4IDM1NDBiNjkwOTQ0Yi4uZjcyN2Y2NDg5Y2Q1IDEwMDY0
NA0KPiA+ID4gLS0tIGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9iaXRvcHMuaA0KPiA+ID4gKysr
IGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9iaXRvcHMuaA0KPiA+ID4gQEAgLTE1LDEzICsxNSwy
NzMgQEANCj4gPiA+ICAjaW5jbHVkZSA8YXNtL2JhcnJpZXIuaD4NCj4gPiA+ICAjaW5jbHVkZSA8
YXNtL2JpdHNwZXJsb25nLmg+DQo+ID4gPg0KPiA+ID4gKyNpZiAhZGVmaW5lZChDT05GSUdfUklT
Q1ZfSVNBX1pCQikgfHwgZGVmaW5lZChFRklfTk9fQUxURVJOQVRJVkUpDQo+ID4gPiAgI2luY2x1
ZGUgPGFzbS1nZW5lcmljL2JpdG9wcy9fX2Zmcy5oPg0KPiA+ID4gLSNpbmNsdWRlIDxhc20tZ2Vu
ZXJpYy9iaXRvcHMvZmZ6Lmg+DQo+ID4gPiAtI2luY2x1ZGUgPGFzbS1nZW5lcmljL2JpdG9wcy9m
bHMuaD4NCj4gPiA+ICAjaW5jbHVkZSA8YXNtLWdlbmVyaWMvYml0b3BzL19fZmxzLmg+DQo+ID4g
PiArI2luY2x1ZGUgPGFzbS1nZW5lcmljL2JpdG9wcy9mZnMuaD4NCj4gPiA+ICsjaW5jbHVkZSA8
YXNtLWdlbmVyaWMvYml0b3BzL2Zscy5oPg0KPiA+ID4gKw0KPiA+ID4gKyNlbHNlDQo+ID4gPiAr
I2luY2x1ZGUgPGFzbS9hbHRlcm5hdGl2ZS1tYWNyb3MuaD4NCj4gPiA+ICsjaW5jbHVkZSA8YXNt
L2h3Y2FwLmg+DQo+ID4gPiArDQo+ID4gPiArI2lmIChCSVRTX1BFUl9MT05HID09IDY0KQ0KPiA+
ID4gKyNkZWZpbmUgQ1RaVyAgICJjdHp3ICINCj4gPiA+ICsjZGVmaW5lIENMWlcgICAiY2x6dyAi
DQo+ID4gPiArI2VsaWYgKEJJVFNfUEVSX0xPTkcgPT0gMzIpDQo+ID4gPiArI2RlZmluZSBDVFpX
ICAgImN0eiAiDQo+ID4gPiArI2RlZmluZSBDTFpXICAgImNseiAiDQo+ID4gPiArI2Vsc2UNCj4g
PiA+ICsjZXJyb3IgIlVuZXhwZWN0ZWQgQklUU19QRVJfTE9ORyINCj4gPiA+ICsjZW5kaWYNCj4g
Wy4uLl0NCg==
