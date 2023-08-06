Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B6C771474
	for <lists+linux-efi@lfdr.de>; Sun,  6 Aug 2023 12:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjHFKYd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Aug 2023 06:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjHFKYc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 6 Aug 2023 06:24:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58017131;
        Sun,  6 Aug 2023 03:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691317471; x=1722853471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=me4Ig/agckbaVNDn2gvomakbHvr8PEZG9zh5+tZ02ds=;
  b=ILj8ULEA3+SMX4pwCwUGqgaFqWLMHH56MwNj/v0Rmouo/j/6sbKTVniR
   pTTsWnuw2NOTgPU6UozqRfAlzqioMRYEmayaQcpaNmTz9Zr4fVO2Xy8ai
   RVD1aFazfsDy/3Wx2tULXtofiEbXjn6R97iPlxQIGMDsolDHinL7acQXH
   jPzbaf8IjCOqDdQZ1XEMFAOd/tYnO+7SdX7dxDYYjoe/BCiBA7sZLNn3X
   YTEdRzx6eBlNYnqr3zzk7WYZ7Cot3a63S84TzIjudyabRLtqVODzg0vnv
   Z772FvPKchcQhPWDBaiKM9C/5XvAWqnvxngLhhrcZN051N4ixbAJhcd5E
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="360443057"
X-IronPort-AV: E=Sophos;i="6.01,259,1684825200"; 
   d="scan'208";a="360443057"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 03:24:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="800613609"
X-IronPort-AV: E=Sophos;i="6.01,259,1684825200"; 
   d="scan'208";a="800613609"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 06 Aug 2023 03:24:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 6 Aug 2023 03:24:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 6 Aug 2023 03:24:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 6 Aug 2023 03:24:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 6 Aug 2023 03:24:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUztWEJz4w75odd2ZBAebdWNozhMFKqEyf3ZtMagfGDtg8ghV9fHvaKq9ZHCXnR8z8Ks1YLHM2VLD7EM5nlLMBVqAU/wLifXT2pEuidt1FdTxpEuvQYBz31W5bt7+Cby0jxEd6rYghXU/tPBqTz3Y5dB6sUThCUv1WIiLmJ2GO78PSe3Gr5Ngll9lI4S5Dict07NcST2pgZXInkT96+iIPsfvQ56G181TlTQORXigPhhwV3qH0r4XvrOSATbIAq+j4KmraXpSbP3OvmVaEfBNdW+B4/LthqwovyLOV04FECW38fWKNdfdrU9bHSR8z9yLklctL6vwlfDv8kZJ5Uddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=me4Ig/agckbaVNDn2gvomakbHvr8PEZG9zh5+tZ02ds=;
 b=HhVcscAYZj7E4xgdCsoPlb8Yul3t36ymnRO5qmbj1ip98LgHEqGcl43rUzZZaxYGaTbynN9NOKESeKiBqLHSBIhCAmuXDjKkwUAc4TN8rEICBFd82ku4U8Ar7HE/2n74WYHGrQB1QrlYBELtaLh3G2PZp1dGSfusKAg9zbbNHalL5ronxMREjoWFN62vhlrQGe2VP8f4gt3gM54lrnguldde15lSwHBV6pBcuUvXqP7ppIS2onRR+Aon98HhKzRLr8HqSl/saRWZnqkJ4e2gA9kq6wkUSJ8jKTPNhg2+ebRX2crBdsJPmAhcYdaEaTLVQR3FhIwrmqOxXy0RUvUT6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 SJ0PR11MB6766.namprd11.prod.outlook.com (2603:10b6:a03:47c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Sun, 6 Aug
 2023 10:24:21 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531%3]) with mapi id 15.20.6652.025; Sun, 6 Aug 2023
 10:24:21 +0000
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
Thread-Index: AQHZyA83tlYFgJbtxEiuzFgm3vAb3a/dA3eAgAAJ0KA=
Date:   Sun, 6 Aug 2023 10:24:21 +0000
Message-ID: <DM8PR11MB5751DA69DEEAAC9B06623E0BB80FA@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20230806024715.3061589-1-xiao.w.wang@intel.com>
 <CAMj1kXHicVpT7PDSB=BgYEuhBxgufHqd9X8ZCg19k0_U+rjvEg@mail.gmail.com>
In-Reply-To: <CAMj1kXHicVpT7PDSB=BgYEuhBxgufHqd9X8ZCg19k0_U+rjvEg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|SJ0PR11MB6766:EE_
x-ms-office365-filtering-correlation-id: 823b9fa9-c312-455b-3030-08db96674ca8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PX6iSiSLjHfBD88Vf8//kTSoXIa/6jbEp1lvp+F5E0LWcXTHjcaqh8nQsTlYO5qzQL2k86eR271QI1glHEBT2g4AatUFEqEQ50uG/9699kig/ciVcXLJ2C9fbNF+aYf54U9LCmfTh4Q9FUMYIfrsEqN7mrSy9TzsNOnMYlmAzkhWVktF1/ILh5aBRRtmIM6gimwHI3qPeMqPV/4z2g6dtr1Z+Gi8nYP++8QnnqwkJZ1hO8QXMVsAArVEBz59iXvp7eDBjuAcIKHODhiz8zBBGKTlX6k3f28mQEhe2MhD82dgLGhbhl90y5ms5xzWpwHOGFz07ySaPETkcm3hAetKyBJA6YMefylF3J0mE7KM0ziUW2sDxgMwvmaprcqj646kEzispTm46IvsurWMJKL7zxrSIPpI7kCZ7Aht7VLuaWC/+q/2vsL0X3muaU8MlkeIK1+sMV64BkVukz2dY1qi2Z/y5Od9qDlyX16k0u1jABFnhi2jZAo51kuvxaT76RZrr8mivfhn6GOnAX1YIeIVK0dR7HLVcnyLMcUeXVw2YFRihAyfTnq9QXIbi046nQD9M9z8KIu0Gw7nSU7w1uLk18mEqZZFrcbq4otTnQW8c5L3aTt+e/rshP+sgld3p0r2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(376002)(346002)(39860400002)(186006)(1800799003)(451199021)(33656002)(86362001)(38070700005)(83380400001)(55016003)(54906003)(478600001)(38100700002)(82960400001)(122000001)(8676002)(53546011)(26005)(6506007)(52536014)(9686003)(41300700001)(8936002)(71200400001)(7696005)(316002)(4326008)(76116006)(6916009)(66446008)(66946007)(66556008)(64756008)(2906002)(66476007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2lkQ2FFNFhISEJxVDUycUVucHVvVDBESFFPb3Qyci8vK2NpenNLMDA2UVox?=
 =?utf-8?B?ZGN3WEgxM2Z4Qjl0S0NIMm9URXM2Tzd3R2lydC83c1ZEWWNkdXBLWC9ZSmlO?=
 =?utf-8?B?S2l3S1dldml4dE1oamZ1Sm9WVnZSWDZhdm5qUTNnb0hFMXgyVUV6OUFJdDF2?=
 =?utf-8?B?RGRCaFVTVURsSVJOVE1mL0FvZW4vLzFreUx2ZzFZSXNtckhCSjVOeGRWRUhr?=
 =?utf-8?B?Z2VpVE95WE5nc0l3M0lGZUZBSndaOFd2SzVaRm8xWElxdzlFY0MyR2lJMHlS?=
 =?utf-8?B?Nk5qYlhCM1Fjb2FQOUYyMlJKcmd2aDBzREhoMVFqVWZFb3ZSQzZVRzZEUXli?=
 =?utf-8?B?eXhOakNrSllxa21nSkFsWTZaRUQzaXpaREpIMlppNWxXYitUSWpyaW5mcEdI?=
 =?utf-8?B?VklwYlErVXNFMlRsNWgzcGZQQnVob2ZKYmZOR3RpVFpKUVYybHNtdmFhNzlW?=
 =?utf-8?B?ckJDTjhoU0JtMmRsWVl3WGdPVW1yekxML3kycEJZNWJhSlB0dkdvRWNsWGFV?=
 =?utf-8?B?YnduUW4zMzZ5bUZDaG5qUzlnS3IySWNucDRpT1hZMGJxdDRKTFBGc1p2NEto?=
 =?utf-8?B?UEJuTmhpRVN5T2psTVZtY3NFS2xJZDVBNm95MUZIelBuNUdCc21BNW1rL2tX?=
 =?utf-8?B?SHYrVzFJbk1qL3MwbnFSZmFDNlFrRXRheUhkRG9RSHJTb2FqdjBTbWNBOE9V?=
 =?utf-8?B?OVVUS1pLTEhxQ2d2WlNHbSt2dzZxaWdRYzM5NVlPY05BK09NVHJXS1lvbE9m?=
 =?utf-8?B?T0JGT09IWXROMW5yY2JUQ0FuSzB6L3R3UmRnR3VWeG9UUFNHRnQ1S0h0RzBV?=
 =?utf-8?B?MEJDcnZsbDM0UWd0TnZlZWRzaDg0T29VNEVaNm54ZUZSdTI2MnFRQWQrTkJ5?=
 =?utf-8?B?M3U4bFRpTC9Wc3NmRTFjd0swZEhGWWFQY1pvZ0F1MDUrU1g4SUtRa2plQTJD?=
 =?utf-8?B?OUVxaW9idTBqeC9hOGFDODdLU0s0VGROL3JOTFRmWGwwM0VLZzJtenYvT1RB?=
 =?utf-8?B?YUtHZWdiRnZTcUNhNjZQMjZoWWV2R1JFSjU3ZlF4R1hRY1R6ZVVHcWRjL0hu?=
 =?utf-8?B?Ulo2VkJRRTI5VUM2Z0RtMWpwRmYwRFl1c3RyYUVLVGg2M2pQbm8rY2hoeDcw?=
 =?utf-8?B?akVtY3QvSVYxWWk2VkM3MzVvNzlrUnNudkg2NmZ1ZWowR1djTTBFV01OMzhN?=
 =?utf-8?B?cEtKaXo1N0tvQlBVODkvQkNJQTBwaVRoSFNWekJ1RDBjMTZ2UFEyZnZGMUpy?=
 =?utf-8?B?anJHMXgyOEw0UlFXaXdYYzBmNGtyUzl0RWdXQ2xLdGJOK0dEUEg1VnN3RFUx?=
 =?utf-8?B?bXJFeGxqMXlqbysxcTFTdlN6eVJJUlpJSVErWGU3dVJVTUpZQTVBS01qNkh0?=
 =?utf-8?B?OW8ySXAyYlRta0sxR1AzUGVUYkNMR0xUS2hhMkFQQWlqamoyZTE2Q29pK0xB?=
 =?utf-8?B?WlhrWitZT0Q1QzdabGtkOUtvbkVsZk93UUFVanZnSGRxTWZTZEIzTDJCbzAx?=
 =?utf-8?B?czlOVURsVVpnZ0R6ZWdCUjBMbXpYdGVGR0FxY1hXdFpGWUlXMllmUDRzOW9L?=
 =?utf-8?B?VG5tbTRxQktINzlSS1NIemdqVVE4cHdnTkZmVGNNNUtFbVhGazBlNmJMNEor?=
 =?utf-8?B?MTFYMllkRDFicklvK3hOSlJnWEcwbFFqVHkyNk5nZC9jcVBpTHd1REVHcG1o?=
 =?utf-8?B?U2lTREVLbXVIZkNlbGp4eEx1TDRsbi9xYmY0YzlWYlRlNFFPYXF5Ykg4MWJC?=
 =?utf-8?B?RG13ZUdjN3NNcGNvNVY1M1JXS290V2luMTJqdWt3aENFbDlGbHdjYXduMkVU?=
 =?utf-8?B?elFVWWFXQmNjeUNtRTBtVnhrbXd1TU1hK0cyeTd2L1pqbXI2bVFBSS9LVWJu?=
 =?utf-8?B?a1BESHVDc0xzdnEzMHFLY0NZY0g4a0hKbGpia2NyZUYwZkcwVXcwcUF0b1pW?=
 =?utf-8?B?bTJYMERUTUhkL3QwZkpxZUx0YlBPdDlYSmxuV0NsYzNQdHoxUWk1SXJGM2pX?=
 =?utf-8?B?OEhSdllmMDFzaVRkaStkUEJwazcxWmhXdVhsZDN2clBJQVhuYm9rUjRYS0Uy?=
 =?utf-8?B?d3c5SHB6UDdTOGpTU3hNMWdZc0d5Ymt5ZDh5Sjk1NEJCeU40emtkNWZiZ2M5?=
 =?utf-8?Q?Az7OLluskr8LzKZHwGDEgtuXc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823b9fa9-c312-455b-3030-08db96674ca8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2023 10:24:21.4653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UfAHCRSlzd+4XidJ4sVj4cYXHjqawfHH8L6Y4B6vFXdQf3kF5Glu0G0I51/UO6G6ECmPk0D3u0G74GIkRctCxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6766
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJkIEJpZXNoZXV2
ZWwgPGFyZGJAa2VybmVsLm9yZz4NCj4gU2VudDogU3VuZGF5LCBBdWd1c3QgNiwgMjAyMyA1OjM5
IFBNDQo+IFRvOiBXYW5nLCBYaWFvIFcgPHhpYW8udy53YW5nQGludGVsLmNvbT4NCj4gQ2M6IHBh
dWwud2FsbXNsZXlAc2lmaXZlLmNvbTsgcGFsbWVyQGRhYmJlbHQuY29tOw0KPiBhb3VAZWVjcy5i
ZXJrZWxleS5lZHU7IGFudXBAYnJhaW5mYXVsdC5vcmc7IExpLCBIYWljaGVuZw0KPiA8aGFpY2hl
bmcubGlAaW50ZWwuY29tPjsgbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgt
DQo+IGVmaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSF0gUklTQy1WOiBPcHRpbWl6ZSBiaXRvcHMgd2l0aCBaYmIgZXh0
ZW5zaW9uDQo+IA0KPiBPbiBTdW4sIDYgQXVnIDIwMjMgYXQgMDQ6MzksIFhpYW8gV2FuZyA8eGlh
by53LndhbmdAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoaXMgcGF0Y2ggbGV2ZXJhZ2Vz
IHRoZSBhbHRlcm5hdGl2ZSBtZWNoYW5pc20gdG8gZHluYW1pY2FsbHkgb3B0aW1pemUNCj4gPiBi
aXRvcHMgKGluY2x1ZGluZyBfX2ZmcywgX19mbHMsIGZmcywgZmxzKSB3aXRoIFpiYiBpbnN0cnVj
dGlvbnMuIFdoZW4NCj4gPiBaYmIgZXh0IGlzIG5vdCBzdXBwb3J0ZWQgYnkgdGhlIHJ1bnRpbWUg
Q1BVLCBsZWdhY3kgaW1wbGVtZW50YXRpb24gaXMNCj4gPiB1c2VkLiBJZiBaYmIgaXMgc3VwcG9y
dGVkLCB0aGVuIHRoZSBvcHRpbWl6ZWQgdmFyaWFudHMgd2lsbCBiZSBzZWxlY3RlZA0KPiA+IHZp
YSBhbHRlcm5hdGl2ZSBwYXRjaGluZy4NCj4gPg0KPiA+IFRoZSBsZWdhY3kgYml0b3BzIHN1cHBv
cnQgaXMgdGFrZW4gZnJvbSB0aGUgZ2VuZXJpYyBDIGltcGxlbWVudGF0aW9uIGFzDQo+ID4gZmFs
bGJhY2suDQo+ID4NCj4gPiBJZiB0aGUgcGFyYW1ldGVyIGlzIGEgYnVpbGQtdGltZSBjb25zdGFu
dCwgd2UgbGV2ZXJhZ2UgY29tcGlsZXIgYnVpbHRpbiB0bw0KPiA+IGNhbGN1bGF0ZSB0aGUgcmVz
dWx0IGRpcmVjdGx5LCB0aGlzIGFwcHJvYWNoIGlzIGluc3BpcmVkIGJ5IHg4NiBiaXRvcHMNCj4g
PiBpbXBsZW1lbnRhdGlvbi4NCj4gPg0KPiA+IEVGSSBzdHViIHJ1bnMgYmVmb3JlIHRoZSBrZXJu
ZWwsIHNvIGFsdGVybmF0aXZlIG1lY2hhbmlzbSBzaG91bGQgbm90IGJlDQo+ID4gdXNlZCB0aGVy
ZSwgdGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgbWFjcm8gRUZJX05PX0FMVEVSTkFUSVZFIGZvciB0
aGlzDQo+ID4gcHVycG9zZS4NCj4gPg0KPiANCj4gV2h5PyBUaGUgdW5wYXRjaGVkIHNlcXVlbmNl
cyB3b3JrIGZpbmUsIG5vPw0KDQpJdCB3b3Jrcy4gQnV0IHRoZXJlIHdvdWxkIGJlIGJ1aWxkIHdh
cm5pbmc6IG9ycGhhbiBzZWN0aW9uIGAuaW5pdC5hbHRlcm5hdGl2ZScgZnJvbSBgLi9kcml2ZXJz
L2Zpcm13YXJlL2VmaS9saWJzdHViL2dvcC5zdHViLm8nIGJlaW5nIHBsYWNlZCBpbiBzZWN0aW9u
IGAuaW5pdC5hbHRlcm5hdGl2ZScuIEJlc2lkZXMsIHcvbyB0aGlzIE1BQ1JPLCB0aGUgb3B0aW1p
emVkIHZhcmlhbnQgd291bGQgbmV2ZXIgYmUgdXNlZCBhdCBydW50aW1lLCBzbyB0aGlzIHBhdGNo
IGNob29zZSB0byBkaXNhYmxlIGFsdGVybmF0aXZlLg0KDQpCUnMsDQpYaWFvDQoNCj4gDQo+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IFhpYW8gV2FuZyA8eGlhby53LndhbmdAaW50ZWwuY29tPg0KPiA+
IC0tLQ0KPiA+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2JpdG9wcy5oICAgICAgIHwgMjY2ICsr
KysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gIGRyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0
dWIvTWFrZWZpbGUgfCAgIDIgKy0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNjQgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2lu
Y2x1ZGUvYXNtL2JpdG9wcy5oDQo+IGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9iaXRvcHMuaA0K
PiA+IGluZGV4IDM1NDBiNjkwOTQ0Yi4uZjcyN2Y2NDg5Y2Q1IDEwMDY0NA0KPiA+IC0tLSBhL2Fy
Y2gvcmlzY3YvaW5jbHVkZS9hc20vYml0b3BzLmgNCj4gPiArKysgYi9hcmNoL3Jpc2N2L2luY2x1
ZGUvYXNtL2JpdG9wcy5oDQo+ID4gQEAgLTE1LDEzICsxNSwyNzMgQEANCj4gPiAgI2luY2x1ZGUg
PGFzbS9iYXJyaWVyLmg+DQo+ID4gICNpbmNsdWRlIDxhc20vYml0c3BlcmxvbmcuaD4NCj4gPg0K
PiA+ICsjaWYgIWRlZmluZWQoQ09ORklHX1JJU0NWX0lTQV9aQkIpIHx8IGRlZmluZWQoRUZJX05P
X0FMVEVSTkFUSVZFKQ0KPiA+ICAjaW5jbHVkZSA8YXNtLWdlbmVyaWMvYml0b3BzL19fZmZzLmg+
DQo+ID4gLSNpbmNsdWRlIDxhc20tZ2VuZXJpYy9iaXRvcHMvZmZ6Lmg+DQo+ID4gLSNpbmNsdWRl
IDxhc20tZ2VuZXJpYy9iaXRvcHMvZmxzLmg+DQo+ID4gICNpbmNsdWRlIDxhc20tZ2VuZXJpYy9i
aXRvcHMvX19mbHMuaD4NCj4gPiArI2luY2x1ZGUgPGFzbS1nZW5lcmljL2JpdG9wcy9mZnMuaD4N
Cj4gPiArI2luY2x1ZGUgPGFzbS1nZW5lcmljL2JpdG9wcy9mbHMuaD4NCj4gPiArDQo+ID4gKyNl
bHNlDQo+ID4gKyNpbmNsdWRlIDxhc20vYWx0ZXJuYXRpdmUtbWFjcm9zLmg+DQo+ID4gKyNpbmNs
dWRlIDxhc20vaHdjYXAuaD4NCj4gPiArDQo+ID4gKyNpZiAoQklUU19QRVJfTE9ORyA9PSA2NCkN
Cj4gPiArI2RlZmluZSBDVFpXICAgImN0encgIg0KPiA+ICsjZGVmaW5lIENMWlcgICAiY2x6dyAi
DQo+ID4gKyNlbGlmIChCSVRTX1BFUl9MT05HID09IDMyKQ0KPiA+ICsjZGVmaW5lIENUWlcgICAi
Y3R6ICINCj4gPiArI2RlZmluZSBDTFpXICAgImNseiAiDQo+ID4gKyNlbHNlDQo+ID4gKyNlcnJv
ciAiVW5leHBlY3RlZCBCSVRTX1BFUl9MT05HIg0KPiA+ICsjZW5kaWYNClsuLi5dDQo=
