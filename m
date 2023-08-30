Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5150478D30B
	for <lists+linux-efi@lfdr.de>; Wed, 30 Aug 2023 07:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238435AbjH3FrC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Aug 2023 01:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238376AbjH3Fqt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Aug 2023 01:46:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35F3FC;
        Tue, 29 Aug 2023 22:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693374406; x=1724910406;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iKUSbPPFLE7+jJMnqnFcX96rTKGI3NGW3wG0BmXSMf8=;
  b=FaUlJgisu+vldfQmcQgVcy+iK8QQlIv0Dh061xX/TbAL/1muWVCyXBv+
   MMfDUTwRW+/RFerwZq8eCBwJ2NNlLM+un43xVT8/fKovBCZI/lECHGKJK
   53fCkS9mA8rMWuBA2sxeQHoPBVnQvqVcqjbufPpRMFUSUcan8cxv4T+kW
   nF8Iz0F680ZEdTE23rO6SFIPF7xj2AFr281Z6ykSihlw3Qw0ugI9HLEys
   B1KKxvczVhosX8Usnuzy+iGk3xFa3foU5Iaq4Z5SHDezpzdCfIQvJxemm
   k9yD6JCti2+4axik3uZbiMyQ+Op9S1Dz/cpgx0WyEylzph5xjgXcDpPR5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="374459780"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="374459780"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 22:46:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="732470136"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="732470136"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 29 Aug 2023 22:46:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 22:46:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 22:46:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 22:46:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAaTykHHPLmlqom6/rUz72oCsGlhOivfcU+YdvkMvPiU5ctcxh6L90mp6ol4rXAgRhlCRTfcc06E+G4rF2nvc+DNLZagCphv3lWp0ZbF8LLUaSdIGv5KSgzQgv5vEnYrPRbU57U16p7e9bej9Q+/po+jGDTre/fhUyMJgbboG4OpEIhJ+UFNOhkBAMgJiSQbntMP/GVoJdZfxIJbrp6AqR5mreRgisCyFilS0xcpAQb2XOYumprXy5IKx1QwpflTUMTTljoUmiEfS+E/oq6eZ1b234/6CNT1b1Ww0M35kM6X2+QszgXrmJ5fN2pMaNep/ExltCNq9b7xCCbiGB3kWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKUSbPPFLE7+jJMnqnFcX96rTKGI3NGW3wG0BmXSMf8=;
 b=P7lenKz9hI7XI/FpDpfrZpG2MMHor8dechzI1DCP+akLciuaXKIZZODmTLadMgttSAEE0moZHR1kYF+dZLG+W/6RkPAi5TaBkM1ctkNVHzWGaFQw5myszyxS6WCrblTLdQzE44mPaVxODAsn8ZMDTNljgT50bTbamEmO1myFd99TsDW23aATkmVL+BWoDkJAYDdIC174WHHLps03Lr+1yiNqGSoRzWI7DYvYV3zoW1FzHIF/1/tFBHXjSTgnfUfKdG2K+0GsifRZmAITA0tFZI8v9L0sp5ZSuGmlBr4KCh9E4uolrz2g5Y/67Vh1I7pGe4bxA0MlqSrzU1CQDHofRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 CO1PR11MB4850.namprd11.prod.outlook.com (2603:10b6:303:9c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.35; Wed, 30 Aug 2023 05:46:41 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531%3]) with mapi id 15.20.6745.015; Wed, 30 Aug 2023
 05:46:41 +0000
From:   "Wang, Xiao W" <xiao.w.wang@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "Li, Haicheng" <haicheng.li@intel.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RISC-V: Optimize bitops with Zbb extension
Thread-Topic: [PATCH] RISC-V: Optimize bitops with Zbb extension
Thread-Index: AQHZyA83tlYFgJbtxEiuzFgm3vAb3a/dA3eAgAAJ0KCAIOt48IABq9CAgALU8nA=
Date:   Wed, 30 Aug 2023 05:46:41 +0000
Message-ID: <DM8PR11MB5751239867AD8E114B9C52BAB8E6A@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20230806024715.3061589-1-xiao.w.wang@intel.com>
 <CAMj1kXHicVpT7PDSB=BgYEuhBxgufHqd9X8ZCg19k0_U+rjvEg@mail.gmail.com>
 <DM8PR11MB5751DA69DEEAAC9B06623E0BB80FA@DM8PR11MB5751.namprd11.prod.outlook.com>
 <DM8PR11MB575198187CB962EBE663B7F0B8E1A@DM8PR11MB5751.namprd11.prod.outlook.com>
 <CAMj1kXGCGVhA=bc+2gNZwb7s_H4K6yk54J04pUQ1XPW+8-2COA@mail.gmail.com>
In-Reply-To: <CAMj1kXGCGVhA=bc+2gNZwb7s_H4K6yk54J04pUQ1XPW+8-2COA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|CO1PR11MB4850:EE_
x-ms-office365-filtering-correlation-id: 43b80741-9279-4249-0e4a-08dba91c7c5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NPRRUiTlUf1TgzHVeGgoBXCybnM10w/nTNHcQCmO1Qb2GeS6rVOmmG2C0mndjW1VbZdWgF9+mIgZ1P91NkmpQfXPYIpMakTKpo4jkk9UUwwV0nCFCBMebc70OaBo2DCmDPygvJNUFKv74UInNlvXBSXZU4iolFY3igm5zcouaPEgFUGJA+2BsO+mbXuuDoRwZUZUKT89kQX8UN8e2hixN2CNIPig61xUFmZYv2mv3oso3hMg6YeV5BmzEc7QpGKKA25sNWBWgR3MrEsFHyZ6gueIL4KHIwh9KZB2DAeyG0k+++gYvLqJq43heVCHEWBYN283avVb5SEZVQF6A/HezLXto3KfMlZW00HDzAiVkdNWJYzSv6BaIncezQgjQItQEY5hm0f2K5ZdIqtvwg5gz+bYKxNcmqIq1TwUeq+MaX22Bjy2wzuuwddM9UCcHB7eE8rAh+rtqqjr3gNfzqYbs3v/vtjGeXcD6fvQfoQrvFO39z+gUSbI+EiHxh3yFMl/IZqvZNiGjZDQHIJK/dqmEh7MRPqptd57zKv92M1NZHI3lM+amSqaRVk/cPXsAz/U7m6+U2zwjuEJ4Jcd3gZ9uHlhub+yy4cpHoYoq+CeUO6qaXeWz+Gktds8+gQFs8XM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(186009)(1800799009)(451199024)(4326008)(6506007)(9686003)(7696005)(71200400001)(83380400001)(478600001)(53546011)(26005)(2906002)(66446008)(64756008)(41300700001)(6916009)(54906003)(66476007)(316002)(66556008)(76116006)(5660300002)(8676002)(8936002)(52536014)(66946007)(86362001)(33656002)(55016003)(82960400001)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEw1ZTJKZDJFenhZdER5aW00NUdvc1VLaCtCejRGWkNzVUdXNllHdWhLVFA1?=
 =?utf-8?B?cFJCdCtnSEVRN2pHYUxQemQyQjRJbHN2VjNRYkVWZUNOK0c2Q0pWQWVpTlFs?=
 =?utf-8?B?d0wzTStwcUtoWGxCelcvWHl6OHNvM1JEOGNoSkZpTDV3dzBSQ0k1eG1tdDJr?=
 =?utf-8?B?bVRucjBhSWxTK3lRMy9PaGt2QzdvTGdkVXdXaFVSQkNHZXpLaG83TjB0SFcw?=
 =?utf-8?B?WEFIZmJiTkFSaWcxczcweUpmempMS3haam5IdjVWdE5ueGs0TmFxRUNsSk1v?=
 =?utf-8?B?ZFh6V2x0MDdnQTh1MFAwRW9xeHlnRlR6VDgxUkwwVWg2Y1ZYTnVFdHZ3QVp4?=
 =?utf-8?B?K3hHUXluTWIzcUlLOFk1clZVNGMvdXJ5QUVZS1krU0Uwdlg0RTBmS0xYNUxQ?=
 =?utf-8?B?ZVV2V29WUjJlR0daRUZnOG1ORHg3ZVBPNXhDZUFRYS9xc25zOXlxSFMyRFlv?=
 =?utf-8?B?Ykh4U3BCczNSZ01mUFZ2WVlQTGRtVy9xdFNuKzVZbGRhRklWVVFHQWtLenFH?=
 =?utf-8?B?clYwUXBVR1JENHhZdGlKQXhzOFpHdkJZRk1OSlp4cVFhdmgxb2llTDhyZWl0?=
 =?utf-8?B?RXBiZytRTmZpZVJIYkVEVnZCaWs0K0pnMTlpWnVRalBIVGNMUWJpb0d5NGFs?=
 =?utf-8?B?cjJIM3lQQWRGR2poTkdraFlmUVhDUDZidnNxeXY5YjJEY2pIa3dKekNxOUZM?=
 =?utf-8?B?d3pnQVVZeFJzbVc1MlppOFdmMVorN0t4a0ExUlVwYjFiTnlyWVN0M0JENVI4?=
 =?utf-8?B?YmYxVyt3ZWxQQUd1L1BaSXFQRGZnaUZVOENuSHBndVBaNjRMMnVLL0JmQ1RB?=
 =?utf-8?B?ZHl0VVRxcUJVQmdSdUxHVFRCUlRZekg2ejVoOVdIMDcyUURyWWtiSy9idVhH?=
 =?utf-8?B?eGVxNmZQUnlHSVd5UVhBM0tPQiswK0lmRWU1QnZ1ZFpKSllXVlN3dnQ4cUJS?=
 =?utf-8?B?eU00Z2dlR0ZRTERjc2VtNVlVc3c3eWZvQzcxMlZUSnlXdzQyaWQ3N1NFZ2o5?=
 =?utf-8?B?Nk5idmJGNHdXSXE3a005WXFva3RsSDBkRm9OTkdQdHozSkFCQTdXNll0NWxh?=
 =?utf-8?B?MmVnZ1VTb3JQd014UHZmaXkyY003TkRXek1rdlVFNG14bnZqRjE0cTNtRUt5?=
 =?utf-8?B?Nk9RbkZ6YWVtNUQxZ0NneUNJVDlyZnN1dThIaXAxQjNNeThsTkd2a2gzeVJQ?=
 =?utf-8?B?MUdlMWJRdVlrWTQ3cWRVa2FiSzFTZjJrUksxeUQrVFZuVjJ5ckxjbzg5dVdY?=
 =?utf-8?B?TmllRnc5VTNxa0p0QkJ6RDI5NW80S3IzbjR2eS9icytkTkZOZ3hNalNyQ0gx?=
 =?utf-8?B?bm9LRnJsV2ZzQVR4dit4QVppdHNwa3Q4bTZqOFZBOGVBR0pJM3A4RHp6TkpB?=
 =?utf-8?B?Q0ZEMGRNd2N6MDJHMUpzTnpkMzdENWpGelhOaUh4bnJOWnJzOG9Yd0U1WWdx?=
 =?utf-8?B?VExRU1d3R2RweFBjak85ZzNmODlTSnZNMUpia1RLYm5JeVB1NVZoc1NoYnNU?=
 =?utf-8?B?MVd2MlVFWlZvMXo2U3ozcVpmeUpLVjJrd2N1a0UzUElxOGRUNkh2UkROYWdp?=
 =?utf-8?B?Q1FObEdRNUw5T2pPNzJBeWJ2LzBib3MzS1dQVnUxMjRkZlg5REF6NkxiQVV3?=
 =?utf-8?B?UE5nM01oNzgvenlueDB3UmJpNng1QU9RRXZXWVljOXM0ZFhsTVVXYXFmVlRj?=
 =?utf-8?B?S3pONWtHc29yUnlTS25JcWlHNGVIZlVBM3ZrbDNxOE9uajhRQjlIdm96eVox?=
 =?utf-8?B?dUdjNFp2YVJhR0dQMW1BQWZCS3FpdXdaU1F0dWxhQ3NTZUpOcnREMlBpSVN2?=
 =?utf-8?B?SEE3b0d3MFJDdHo1UExJNEN4MktnN0YxZitCb0hISWxVcGVvcExqRE51Q0Jo?=
 =?utf-8?B?YkFTV2ZZMUE4S0N5dlliclUza3hVMHJWbDE4MTVuVXhHcE4wZnV1akQwdHlv?=
 =?utf-8?B?UnYvTDVzV3RCdXZJQi8wYXVrSHhidStXSFpqWGlLTUhyL2dEREpoT3JwUnRO?=
 =?utf-8?B?VGd0UkdmQUEwL2Z5YkVmbEVucTVsdVMvUHBTM21od2tSdTdNa3lPRFFRL0kr?=
 =?utf-8?B?MllQZkpVUmcraXQ5K1ptclN2U0k5MTZvVU9IYjVvUzlVdXNnRHZ6MzNBZTBF?=
 =?utf-8?Q?fOX8DXEb9AAPFR8sM5eV0IbTh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b80741-9279-4249-0e4a-08dba91c7c5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 05:46:41.3615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDiK3V/uvMogAVsoo60xsvCu+/sfujbBqG/rFJ0vSoJ/RIAIgGwpZoRw3Er9dxHbUN7c1rRnK9CpzuN5lmU0/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4850
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJkIEJpZXNoZXV2
ZWwgPGFyZGJAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgMjgsIDIwMjMgNjoy
OCBQTQ0KPiBUbzogV2FuZywgWGlhbyBXIDx4aWFvLncud2FuZ0BpbnRlbC5jb20+DQo+IENjOiBw
YXVsLndhbG1zbGV5QHNpZml2ZS5jb207IHBhbG1lckBkYWJiZWx0LmNvbTsNCj4gYW91QGVlY3Mu
YmVya2VsZXkuZWR1OyBhbnVwQGJyYWluZmF1bHQub3JnOyBMaSwgSGFpY2hlbmcNCj4gPGhhaWNo
ZW5nLmxpQGludGVsLmNvbT47IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4
LQ0KPiBlZmlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFJJU0MtVjogT3B0aW1pemUgYml0b3BzIHdpdGggWmJiIGV4
dGVuc2lvbg0KPiANCj4gT24gU3VuLCAyNyBBdWcgMjAyMyBhdCAxMToyNiwgV2FuZywgWGlhbyBX
IDx4aWFvLncud2FuZ0BpbnRlbC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gSGksDQo+ID4NCj4g
PiBBIGdlbnRsZSBwaW5nLg0KPiA+IEFueSBvdGhlciBjb21tZW50cyBvciBzdWdnZXN0aW9ucyBm
b3IgdGhpcyBwYXRjaD8gT3IgbWF5YmUgd2Ugd291bGQNCj4gcmV2aWV3IGl0IGluIHRoZSBMaW51
eCA2LjcgZGV2ZWxvcG1lbnQgY3ljbGU/DQo+ID4NCj4gDQo+IFRoaXMgaXMgZ29pbmcgdG8gYmUg
Ni43IG1hdGVyaWFsIGF0IHRoZSBlYXJsaWVzdCBpbiBhbnkgY2FzZS4NCj4gDQo+IEkgYW0gZmlu
ZSB3aXRoIHRoZSBjaGFuZ2UgYXMgZmFyIGFzIHRoZSBFRkkgY29kZSBpcyBjb25jZXJuZWQsIGJ1
dCBJJ2QNCj4gc3VnZ2VzdCBkcm9wcGluZyBFRklfIGZyb20gdGhlIG1hY3JvIG5hbWUsIGFzIGl0
IGNvdWxkIGJlICNkZWZpbmUnZA0KPiBmb3Igb3RoZXIgcmVhc29ucyB0b28uDQoNClllcywgSSBh
Z3JlZSB3aXRoIHlvdS4gV291bGQgcmVtb3ZlIHRoZSBFRklfIHByZWZpeCBpbiBuZXh0IHZlcnNp
b24uDQoNClRoYW5rcywNClhpYW8NCg0KPiANCj4gDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBXYW5nLCBYaWFvIFcNCj4gPiA+IFNlbnQ6IFN1bmRh
eSwgQXVndXN0IDYsIDIwMjMgNjoyNCBQTQ0KPiA+ID4gVG86IEFyZCBCaWVzaGV1dmVsIDxhcmRi
QGtlcm5lbC5vcmc+DQo+ID4gPiBDYzogcGF1bC53YWxtc2xleUBzaWZpdmUuY29tOyBwYWxtZXJA
ZGFiYmVsdC5jb207DQo+ID4gPiBhb3VAZWVjcy5iZXJrZWxleS5lZHU7IGFudXBAYnJhaW5mYXVs
dC5vcmc7IExpLCBIYWljaGVuZw0KPiA+ID4gPGhhaWNoZW5nLmxpQGludGVsLmNvbT47IGxpbnV4
LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiA+ID4gZWZpQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDogUkU6IFtQ
QVRDSF0gUklTQy1WOiBPcHRpbWl6ZSBiaXRvcHMgd2l0aCBaYmIgZXh0ZW5zaW9uDQo+ID4gPg0K
PiA+ID4gSGksDQo+ID4gPg0KPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
ID4gPiBGcm9tOiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPg0KPiA+ID4gPiBTZW50
OiBTdW5kYXksIEF1Z3VzdCA2LCAyMDIzIDU6MzkgUE0NCj4gPiA+ID4gVG86IFdhbmcsIFhpYW8g
VyA8eGlhby53LndhbmdAaW50ZWwuY29tPg0KPiA+ID4gPiBDYzogcGF1bC53YWxtc2xleUBzaWZp
dmUuY29tOyBwYWxtZXJAZGFiYmVsdC5jb207DQo+ID4gPiA+IGFvdUBlZWNzLmJlcmtlbGV5LmVk
dTsgYW51cEBicmFpbmZhdWx0Lm9yZzsgTGksIEhhaWNoZW5nDQo+ID4gPiA+IDxoYWljaGVuZy5s
aUBpbnRlbC5jb20+OyBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4g
PiA+ID4gZWZpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBSSVNDLVY6IE9wdGltaXplIGJpdG9wcyB3aXRo
IFpiYiBleHRlbnNpb24NCj4gPiA+ID4NCj4gPiA+ID4gT24gU3VuLCA2IEF1ZyAyMDIzIGF0IDA0
OjM5LCBYaWFvIFdhbmcgPHhpYW8udy53YW5nQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiBUaGlzIHBhdGNoIGxldmVyYWdlcyB0aGUgYWx0ZXJuYXRpdmUgbWVjaGFu
aXNtIHRvIGR5bmFtaWNhbGx5IG9wdGltaXplDQo+ID4gPiA+ID4gYml0b3BzIChpbmNsdWRpbmcg
X19mZnMsIF9fZmxzLCBmZnMsIGZscykgd2l0aCBaYmIgaW5zdHJ1Y3Rpb25zLiBXaGVuDQo+ID4g
PiA+ID4gWmJiIGV4dCBpcyBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBydW50aW1lIENQVSwgbGVnYWN5
IGltcGxlbWVudGF0aW9uIGlzDQo+ID4gPiA+ID4gdXNlZC4gSWYgWmJiIGlzIHN1cHBvcnRlZCwg
dGhlbiB0aGUgb3B0aW1pemVkIHZhcmlhbnRzIHdpbGwgYmUgc2VsZWN0ZWQNCj4gPiA+ID4gPiB2
aWEgYWx0ZXJuYXRpdmUgcGF0Y2hpbmcuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGUgbGVnYWN5
IGJpdG9wcyBzdXBwb3J0IGlzIHRha2VuIGZyb20gdGhlIGdlbmVyaWMgQyBpbXBsZW1lbnRhdGlv
biBhcw0KPiA+ID4gPiA+IGZhbGxiYWNrLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSWYgdGhlIHBh
cmFtZXRlciBpcyBhIGJ1aWxkLXRpbWUgY29uc3RhbnQsIHdlIGxldmVyYWdlIGNvbXBpbGVyIGJ1
aWx0aW4NCj4gdG8NCj4gPiA+ID4gPiBjYWxjdWxhdGUgdGhlIHJlc3VsdCBkaXJlY3RseSwgdGhp
cyBhcHByb2FjaCBpcyBpbnNwaXJlZCBieSB4ODYgYml0b3BzDQo+ID4gPiA+ID4gaW1wbGVtZW50
YXRpb24uDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBFRkkgc3R1YiBydW5zIGJlZm9yZSB0aGUga2Vy
bmVsLCBzbyBhbHRlcm5hdGl2ZSBtZWNoYW5pc20gc2hvdWxkIG5vdCBiZQ0KPiA+ID4gPiA+IHVz
ZWQgdGhlcmUsIHRoaXMgcGF0Y2ggaW50cm9kdWNlcyBhIG1hY3JvIEVGSV9OT19BTFRFUk5BVElW
RSBmb3IgdGhpcw0KPiA+ID4gPiA+IHB1cnBvc2UuDQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+
ID4gV2h5PyBUaGUgdW5wYXRjaGVkIHNlcXVlbmNlcyB3b3JrIGZpbmUsIG5vPw0KPiA+ID4NCj4g
PiA+IEl0IHdvcmtzLiBCdXQgdGhlcmUgd291bGQgYmUgYnVpbGQgd2FybmluZzogb3JwaGFuIHNl
Y3Rpb24NCj4gYC5pbml0LmFsdGVybmF0aXZlJw0KPiA+ID4gZnJvbSBgLi9kcml2ZXJzL2Zpcm13
YXJlL2VmaS9saWJzdHViL2dvcC5zdHViLm8nIGJlaW5nIHBsYWNlZCBpbiBzZWN0aW9uDQo+ID4g
PiBgLmluaXQuYWx0ZXJuYXRpdmUnLiBCZXNpZGVzLCB3L28gdGhpcyBNQUNSTywgdGhlIG9wdGlt
aXplZCB2YXJpYW50IHdvdWxkDQo+ID4gPiBuZXZlciBiZSB1c2VkIGF0IHJ1bnRpbWUsIHNvIHRo
aXMgcGF0Y2ggY2hvb3NlIHRvIGRpc2FibGUgYWx0ZXJuYXRpdmUuDQo+ID4gPg0KPiA+ID4gQlJz
LA0KPiA+ID4gWGlhbw0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBYaWFvIFdhbmcgPHhpYW8udy53YW5nQGludGVsLmNvbT4NCj4gPiA+ID4gPiAtLS0N
Cj4gPiA+ID4gPiAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9iaXRvcHMuaCAgICAgICB8IDI2Ng0K
PiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiA+ID4gPiAgZHJpdmVycy9maXJt
d2FyZS9lZmkvbGlic3R1Yi9NYWtlZmlsZSB8ICAgMiArLQ0KPiA+ID4gPiA+ICAyIGZpbGVzIGNo
YW5nZWQsIDI2NCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vYml0b3BzLmgNCj4gPiA+
ID4gYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2JpdG9wcy5oDQo+ID4gPiA+ID4gaW5kZXggMzU0
MGI2OTA5NDRiLi5mNzI3ZjY0ODljZDUgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvYXJjaC9yaXNj
di9pbmNsdWRlL2FzbS9iaXRvcHMuaA0KPiA+ID4gPiA+ICsrKyBiL2FyY2gvcmlzY3YvaW5jbHVk
ZS9hc20vYml0b3BzLmgNCj4gPiA+ID4gPiBAQCAtMTUsMTMgKzE1LDI3MyBAQA0KPiA+ID4gPiA+
ICAjaW5jbHVkZSA8YXNtL2JhcnJpZXIuaD4NCj4gPiA+ID4gPiAgI2luY2x1ZGUgPGFzbS9iaXRz
cGVybG9uZy5oPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gKyNpZiAhZGVmaW5lZChDT05GSUdfUklT
Q1ZfSVNBX1pCQikgfHwNCj4gZGVmaW5lZChFRklfTk9fQUxURVJOQVRJVkUpDQo+ID4gPiA+ID4g
ICNpbmNsdWRlIDxhc20tZ2VuZXJpYy9iaXRvcHMvX19mZnMuaD4NCj4gPiA+ID4gPiAtI2luY2x1
ZGUgPGFzbS1nZW5lcmljL2JpdG9wcy9mZnouaD4NCj4gPiA+ID4gPiAtI2luY2x1ZGUgPGFzbS1n
ZW5lcmljL2JpdG9wcy9mbHMuaD4NCj4gPiA+ID4gPiAgI2luY2x1ZGUgPGFzbS1nZW5lcmljL2Jp
dG9wcy9fX2Zscy5oPg0KPiA+ID4gPiA+ICsjaW5jbHVkZSA8YXNtLWdlbmVyaWMvYml0b3BzL2Zm
cy5oPg0KPiA+ID4gPiA+ICsjaW5jbHVkZSA8YXNtLWdlbmVyaWMvYml0b3BzL2Zscy5oPg0KPiA+
ID4gPiA+ICsNCj4gPiA+ID4gPiArI2Vsc2UNCj4gPiA+ID4gPiArI2luY2x1ZGUgPGFzbS9hbHRl
cm5hdGl2ZS1tYWNyb3MuaD4NCj4gPiA+ID4gPiArI2luY2x1ZGUgPGFzbS9od2NhcC5oPg0KPiA+
ID4gPiA+ICsNCj4gPiA+ID4gPiArI2lmIChCSVRTX1BFUl9MT05HID09IDY0KQ0KPiA+ID4gPiA+
ICsjZGVmaW5lIENUWlcgICAiY3R6dyAiDQo+ID4gPiA+ID4gKyNkZWZpbmUgQ0xaVyAgICJjbHp3
ICINCj4gPiA+ID4gPiArI2VsaWYgKEJJVFNfUEVSX0xPTkcgPT0gMzIpDQo+ID4gPiA+ID4gKyNk
ZWZpbmUgQ1RaVyAgICJjdHogIg0KPiA+ID4gPiA+ICsjZGVmaW5lIENMWlcgICAiY2x6ICINCj4g
PiA+ID4gPiArI2Vsc2UNCj4gPiA+ID4gPiArI2Vycm9yICJVbmV4cGVjdGVkIEJJVFNfUEVSX0xP
TkciDQo+ID4gPiA+ID4gKyNlbmRpZg0KPiA+ID4gWy4uLl0NCg==
