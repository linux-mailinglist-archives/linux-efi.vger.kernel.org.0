Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0725178F0C7
	for <lists+linux-efi@lfdr.de>; Thu, 31 Aug 2023 17:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239380AbjHaP7v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Aug 2023 11:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjHaP7v (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Aug 2023 11:59:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046B31A3;
        Thu, 31 Aug 2023 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693497588; x=1725033588;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KrT07C5DADHF7LQ3jkkFwOSEzYdnXocpn6mVYFPIq8E=;
  b=T9bZPMCXWg+AF+klUJO5q5uNT9xWSsTdHbF8AjGnEJmYOsa+fxEVsDMw
   hEnrKcGrF9h/ZyBML5CwO6borJBzk/K2xyoAIUjvW3lu7tA3N+9T75bY7
   /Nd6+UaRUvIOcvo/j3VU5zjRN89Wk6bJQABwQyUE6PDQzwEvzhr1Ky+im
   PIWkXHbFioNx92ymE07pFAqWmgAyK2ZPQTetPYtnI9KBX15dk54VbTUug
   r2yfGvxtDtx3Kpzi/zxvn+xwJNXe4wJpU7GADNs0J1ShSl87jHmLj/PfW
   PZVSMyUdrs0QiBIJfyz2W3jXkCv0ul9nFLTA22/X6tXronlab/0RZD9ps
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="379769120"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="379769120"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 08:59:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="854323377"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="854323377"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 08:59:46 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 08:59:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 08:59:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 08:59:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 08:59:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Or4hkCiTy7tkdCXQqgL0DZVYydDgKkZE1Fc9WyLwZh4FYkKgM92nwNLZCG6e6aIEtlQ73+gz/8mf4F7PKbKkC0ArEpJQjdJ56ko4MgdShsUcghLSyg9Asl8O6yPinMnkIPGJBcPfz24HjmUKyt8PAL0WzlQhz+BU94q7YM/iWeGBsIcNWMYNNV69eSg1Ib20Wc0GUWUeon7gVn1whU96MMXUsKaMnmAVMby4VowQSTG+Grpf8MDMYHbj0FUVULbY28CaUKp28KDCJIOKw34JqjKlySjclH5miBs3XamYPt5kwfyZDtbpTEfXefAmYBCjE5Ui2FtwJNa3jyPonhXq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrT07C5DADHF7LQ3jkkFwOSEzYdnXocpn6mVYFPIq8E=;
 b=MhU8AYb9vcBoXK7VtGgxqGyAp8VQK4/qLmaDJmgzIqpiLa1L80kr4LUClfNVF8THO37I3/gVIZviOvjMbwMaXAaWMzrNESK8WWyK+9qhVYUykbs0YvHwD+Z/kRwEALs1L9iBSn/ZO6QfgQAHqV53r6qNWb4tK5zZHYHv1CK+r34skRIKkYzAQCNUWMaLDPtnN0JXM9WcAIajEo3U2uyhjpN1gVmTLD4hSkJMQZ/15imCj6Twhdlvn2VVlkSJ0edtIRjAS2DY5PpsYQNKmFxUyBgYKxw8onHgtfTjwhME3SKPcyYmlp+fOMWb18k8nCkAhcfqGZZR6x1DrG6uxvbghA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 BL1PR11MB6028.namprd11.prod.outlook.com (2603:10b6:208:393::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 15:59:42 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531%3]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 15:59:42 +0000
From:   "Wang, Xiao W" <xiao.w.wang@intel.com>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "Li, Haicheng" <haicheng.li@intel.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RISC-V: Optimize bitops with Zbb extension
Thread-Topic: [PATCH] RISC-V: Optimize bitops with Zbb extension
Thread-Index: AQHZyA83tlYFgJbtxEiuzFgm3vAb3bABQgqAgAE4pICAABQygIACJNYw
Date:   Thu, 31 Aug 2023 15:59:42 +0000
Message-ID: <DM8PR11MB575116E5EE183D7D41361B74B8E5A@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20230806024715.3061589-1-xiao.w.wang@intel.com>
 <CAAhSdy2_djw2JX+8tmF2V190+x9KLvt7u8rCX-TaGCKQrUVOYQ@mail.gmail.com>
 <DM8PR11MB57512001CAFA07EC58203A7BB8E6A@DM8PR11MB5751.namprd11.prod.outlook.com>
 <20230830-breeze-washboard-ef496d5c9d5a@wendy>
In-Reply-To: <20230830-breeze-washboard-ef496d5c9d5a@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|BL1PR11MB6028:EE_
x-ms-office365-filtering-correlation-id: 0ffa9a5d-f480-47a8-2c21-08dbaa3b4a18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6TWlndFwE8GhV/WClki1Kal8ue7E0GoYLrR+OWEX5DXGfk4JNNXeuDK2ZxIsYWKeH7sdj7dZ6O5k1/qStu4qgNsP4fAJOxGFwLQN6h9bWfGOHuD5kL/Fh9eB+Y8g6J+UTiYMJPmSA+p50bYVv/jiCo18ltvf2u6rMOvJzPxD5gEMLhNUHbKtR3KcOttuRylV2q0CSh36TzlfkPBMBtjleeR1dAyam+zr04WW8jCVFRUCeeroWwMpqNfMve4mXhY+IUEyKRwV6VuaqtgExkXfJEZiaRp8GBKXLxBHed4UP8BD+/sS9G815JLHieor910ncVvoHy71dcFN9W+owxWA3Yl8ItMMxweBEhn7QkfBqHvAzVdT/e3DLWjYhCpG+BNurzKpHyV/A47dsWWccrncjjjhVeGl39vs4pvWOwObAHuAYO99bq3Pw2jMW9ZM3+I6/frXOHNYx9mPHgi+zlKpicgbnyK1XKKgkLDYVkaENq0TAZKlCPODpkhkz6veho5F7TGSBDMg0pUr2++bby9j9GgmCnyD4/JVvmVRU9Y7KdHHZ+O6qmU8DrGeV/6dXeH22TVQBX20KLrkdZhWDEcVqMZpYeAhmEoDHj2g4TDdBiqUcFcfoMAd3p+sBQM7T2xOTNzwUtQzKhZVb9QGQq3p+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(1800799009)(451199024)(186009)(71200400001)(52536014)(2906002)(86362001)(5660300002)(53546011)(122000001)(316002)(82960400001)(478600001)(4326008)(8676002)(6506007)(7696005)(9686003)(8936002)(54906003)(33656002)(966005)(26005)(38100700002)(38070700005)(55016003)(41300700001)(83380400001)(66946007)(64756008)(66476007)(66446008)(66556008)(76116006)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlBaditkdTJyeVlxMGhIbXJ2NTZ5a1Y3ZDFRTmlJaWxSU3lwaHJxdS92U2NG?=
 =?utf-8?B?bVV1N3Q2S1BVbUdHQVByaTQ0YS95QVZqb2s2bFpzVjRqT3A3S1FWMzFZaE5o?=
 =?utf-8?B?UnQ0Tkh6VDF2MkNvdnBMaXlMaEljQ2dwMnZFcGFSUXE1Q1BVOE95aDFDWTI0?=
 =?utf-8?B?VS94dWJhdVNOdklzSEkrRHp1ZXVoQkM0UEIrT1lIZERjNW5yTXZjSmZQVDdX?=
 =?utf-8?B?azNFUi80dkFIRUZzTEJCRDJId1crV2lRbjNqWGNqVHVVRWFwcWh2NExhYURq?=
 =?utf-8?B?aXVROGo3cnB0U3o5NzkxV3NJdWJuVFppQXMreFMzYStwcnNsSWl0ejMwOHNa?=
 =?utf-8?B?VHNUcHhHZG9ONVFra2x0RjJxVTgxN0IySjcxQTRpSWtKY3pyMmRldFRQRTRa?=
 =?utf-8?B?eWVKR2RmWk1HNWFET3U1R1NVT3laRC9vdkk4ajUvSGhSZ01rZXZtZHVaZ0Q0?=
 =?utf-8?B?QnEzMk5kOUYydlI1M2tvQ0FBRjNVdzBuaWdsbDR6VlN6eEZsQVEyUHB6WlVD?=
 =?utf-8?B?UzNKOTNhSTMySE41amlmTHU4UFJoVXVKbVpjbUJueWozOTJlVlllUnRmMGxH?=
 =?utf-8?B?MDJRVGxsSDZoMDlrVU9jS0QyZ3YyUnhWNEgzcDBOWEd6VERrc09ZZlhXbm1T?=
 =?utf-8?B?ejZLdXJ2KzR6RnJXMHdiY0ZxMUJOeGNoTnkvVHQzNkpLb0pSaFhzWTFnTE5t?=
 =?utf-8?B?SlZlMjdHaFo0cEVseXBiU1VWckpqSUdCYUsxbEw4NEtabi9nKzV4STMxelRC?=
 =?utf-8?B?b0E0YWhpQjVtM29zQmZZc1FVTlNVblVEbmJhVzF5ejB2cnU2dnBTOVE2VEFP?=
 =?utf-8?B?SnVuVHRXY014NGhuaDkzc1FDT3paM2l2dUpHbXVVZkE1L3ptSGFZWjZIS2g2?=
 =?utf-8?B?MkplSDc4MzhIYi9IUlQ2V3VXM0xvdVFWL293WmlOV01DeFk0NWl6Zk43SHRv?=
 =?utf-8?B?Qlo3MENwU2R5aHpSNkk3RE52aDYwakxqNml1VE9NRXZ4eXNNV3hNeS9HK21m?=
 =?utf-8?B?bXkycStKRi9ETms0S2tyOU9PbUxZRHpiZmhpYXZXNXJYY2hWTHBZdDlyRnFL?=
 =?utf-8?B?NXcyRWtDTVRqZUJOUlBKcnlaREF1Nncydm56Tzdkb3k4U2tOckNuTkZOVW1Q?=
 =?utf-8?B?MXQvME11c2ZMWnF6UG0wUkIzMnJoUGJSekdhanRCdFA3RXdXdFY0VU96ZVgx?=
 =?utf-8?B?RVNpdk5GeHRHUW95TFlad05zdTBOb1hrZ0FLK0F4ZCtzL04vTGl6akJvUUdm?=
 =?utf-8?B?ZVpKbGFCclg4YzVXT0RISVBnWjNuLzNWOWUvR3lmZ0I3SmJEN1NHM0NVLyti?=
 =?utf-8?B?blhGRGkzYVFLMEdabXhBb0toUGlmNDRlZkw3dE15RkZXQXRNMytGUE5oZSto?=
 =?utf-8?B?NndPSkxPQmdqQmdMd2dzTEp1REtyb3ZMUzhxNnlNVXloVmh1NDFEQWhBVSs4?=
 =?utf-8?B?QnEyR1lNclo0eXpESHlXeHFPU3M5UXdvUlk1Q0w4b2JMSTFjRW9CT0Q0VWxj?=
 =?utf-8?B?V2hjZnNUbW5rSjlBNVVqTmdXQXBsdnBiTC8vYmh1ZExJVERlSzl6S3YxZUZS?=
 =?utf-8?B?b282aDhkR0FiL3M0NktiYWROUXhScXR0cnNJS0wrTWgrNnl6TDhNL2M3QjI0?=
 =?utf-8?B?T1c0dkhJZ0hPRDM3WTZ0em4yV00yVVJ0VlkyVmlUUFM0YU9IVVhiZUNicU5n?=
 =?utf-8?B?cGJwNlkwMFB3REVoallvNC9QdzdWc2RKTkxROHphQ1ltak1PM3BSTE9OU29F?=
 =?utf-8?B?S1MzaDlCNmhPMktleWg1ajluTnlCK2Vzems1UFJxQUJ5cWxEWDZyOVVybHZG?=
 =?utf-8?B?Zzd6MEh2TU9FbVFIbFV3OXNKdlIyYTVUd0RUVmF1RGJFdmVKVjJuYmx5RU0y?=
 =?utf-8?B?dElWcWNzZHFBSHptQmo2Z3gzYWlnTXRxV3JTcVEweHFHTjVtb1VwSUNEdnpC?=
 =?utf-8?B?R2RSd0I4Um9IS1M3eGNVQmJieXpiMVVMQ01wQ0NobHZleU5VSGJtcGR0WEk3?=
 =?utf-8?B?a0J6Y0V3UlV0OUQ4S210TWRSbWRqNGszRDBmdW5zNUJtR3NCT0ZBbFM5MmFY?=
 =?utf-8?B?cFlFejhHMUdsc2Q1TXgyMVl1STBTK1NvT1NhNURKUXJUWUFOOUVmWjMraW5L?=
 =?utf-8?Q?NjRER7YgEsSSsL32XFpVKxzj2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffa9a5d-f480-47a8-2c21-08dbaa3b4a18
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 15:59:42.5680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iEtop29AdzSNjPDr0JmkKM67/iwrWdLp0RMHWPhI4KaGYO+7/mQo3gLtRzLiqdleOPD1Q6PU9/LNlK6BQ8c4HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6028
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENvbm9yIERvb2xleSA8Y29u
b3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDMwLCAy
MDIzIDI6NTkgUE0NCj4gVG86IFdhbmcsIFhpYW8gVyA8eGlhby53LndhbmdAaW50ZWwuY29tPg0K
PiBDYzogQW51cCBQYXRlbCA8YW51cEBicmFpbmZhdWx0Lm9yZz47IHBhdWwud2FsbXNsZXlAc2lm
aXZlLmNvbTsNCj4gcGFsbWVyQGRhYmJlbHQuY29tOyBhb3VAZWVjcy5iZXJrZWxleS5lZHU7IGFy
ZGJAa2VybmVsLm9yZzsgTGksIEhhaWNoZW5nDQo+IDxoYWljaGVuZy5saUBpbnRlbC5jb20+OyBs
aW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4gZWZpQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSBSSVNDLVY6IE9wdGltaXplIGJpdG9wcyB3aXRoIFpiYiBleHRlbnNpb24NCj4gDQo+IE9uIFdl
ZCwgQXVnIDMwLCAyMDIzIGF0IDA2OjE0OjEyQU0gKzAwMDAsIFdhbmcsIFhpYW8gVyB3cm90ZToN
Cj4gPiBIaSwNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZy
b206IEFudXAgUGF0ZWwgPGFudXBAYnJhaW5mYXVsdC5vcmc+DQo+ID4gPiBTZW50OiBUdWVzZGF5
LCBBdWd1c3QgMjksIDIwMjMgNzowOCBQTQ0KPiA+ID4gVG86IFdhbmcsIFhpYW8gVyA8eGlhby53
LndhbmdAaW50ZWwuY29tPg0KPiA+ID4gQ2M6IHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbTsgcGFs
bWVyQGRhYmJlbHQuY29tOw0KPiA+ID4gYW91QGVlY3MuYmVya2VsZXkuZWR1OyBhcmRiQGtlcm5l
bC5vcmc7IExpLCBIYWljaGVuZw0KPiA+ID4gPGhhaWNoZW5nLmxpQGludGVsLmNvbT47IGxpbnV4
LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiA+ID4gZWZpQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gUklTQy1WOiBPcHRpbWl6ZSBiaXRvcHMgd2l0aCBaYmIgZXh0ZW5zaW9uDQo+ID4gPg0K
PiA+ID4gT24gU3VuLCBBdWcgNiwgMjAyMyBhdCA4OjA54oCvQU0gWGlhbyBXYW5nIDx4aWFvLncu
d2FuZ0BpbnRlbC5jb20+DQo+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIHBhdGNoIGxl
dmVyYWdlcyB0aGUgYWx0ZXJuYXRpdmUgbWVjaGFuaXNtIHRvIGR5bmFtaWNhbGx5IG9wdGltaXpl
DQo+ID4gPiA+IGJpdG9wcyAoaW5jbHVkaW5nIF9fZmZzLCBfX2ZscywgZmZzLCBmbHMpIHdpdGgg
WmJiIGluc3RydWN0aW9ucy4gV2hlbg0KPiA+ID4gPiBaYmIgZXh0IGlzIG5vdCBzdXBwb3J0ZWQg
YnkgdGhlIHJ1bnRpbWUgQ1BVLCBsZWdhY3kgaW1wbGVtZW50YXRpb24gaXMNCj4gPiA+ID4gdXNl
ZC4gSWYgWmJiIGlzIHN1cHBvcnRlZCwgdGhlbiB0aGUgb3B0aW1pemVkIHZhcmlhbnRzIHdpbGwg
YmUgc2VsZWN0ZWQNCj4gPiA+ID4gdmlhIGFsdGVybmF0aXZlIHBhdGNoaW5nLg0KPiA+ID4gPg0K
PiA+ID4gPiBUaGUgbGVnYWN5IGJpdG9wcyBzdXBwb3J0IGlzIHRha2VuIGZyb20gdGhlIGdlbmVy
aWMgQyBpbXBsZW1lbnRhdGlvbiBhcw0KPiA+ID4gPiBmYWxsYmFjay4NCj4gPiA+ID4NCj4gPiA+
ID4gSWYgdGhlIHBhcmFtZXRlciBpcyBhIGJ1aWxkLXRpbWUgY29uc3RhbnQsIHdlIGxldmVyYWdl
IGNvbXBpbGVyIGJ1aWx0aW4gdG8NCj4gPiA+ID4gY2FsY3VsYXRlIHRoZSByZXN1bHQgZGlyZWN0
bHksIHRoaXMgYXBwcm9hY2ggaXMgaW5zcGlyZWQgYnkgeDg2IGJpdG9wcw0KPiA+ID4gPiBpbXBs
ZW1lbnRhdGlvbi4NCj4gPiA+ID4NCj4gPiA+ID4gRUZJIHN0dWIgcnVucyBiZWZvcmUgdGhlIGtl
cm5lbCwgc28gYWx0ZXJuYXRpdmUgbWVjaGFuaXNtIHNob3VsZCBub3QgYmUNCj4gPiA+ID4gdXNl
ZCB0aGVyZSwgdGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgbWFjcm8gRUZJX05PX0FMVEVSTkFUSVZF
IGZvciB0aGlzDQo+ID4gPiA+IHB1cnBvc2UuDQo+ID4gPg0KPiA+ID4gSSBhbSBnZXR0aW5nIHRo
ZSBmb2xsb3dpbmcgY29tcGlsZSBlcnJvciB3aXRoIHRoaXMgcGF0Y2g6DQo+ID4gPg0KPiA+ID4g
ICBHRU4gICAgIE1ha2VmaWxlDQo+ID4gPiAgIFVQRCAgICAgaW5jbHVkZS9jb25maWcva2VybmVs
LnJlbGVhc2UNCj4gPiA+ICAgVVBEICAgICBpbmNsdWRlL2dlbmVyYXRlZC91dHNyZWxlYXNlLmgN
Cj4gPiA+ICAgQ0MgICAgICBrZXJuZWwvYm91bmRzLnMNCj4gPiA+IEluIGZpbGUgaW5jbHVkZWQg
ZnJvbSAvaG9tZS9hbnVwL1dvcmsvcmlzY3YtDQo+ID4gPiB0ZXN0L2xpbnV4L2luY2x1ZGUvbGlu
dXgvYml0bWFwLmg6OSwNCj4gPiA+ICAgICAgICAgICAgICAgICAgZnJvbQ0KPiA+ID4gL2hvbWUv
YW51cC9Xb3JrL3Jpc2N2LQ0KPiB0ZXN0L2xpbnV4L2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vY3B1
ZmVhdHVyZS5oOjksDQo+ID4gPiAgICAgICAgICAgICAgICAgIGZyb20NCj4gPiA+IC9ob21lL2Fu
dXAvV29yay9yaXNjdi10ZXN0L2xpbnV4L2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vaHdjYXAuaDo5
MCwNCj4gPg0KPiA+DQo+ID4gSXQgbG9va3MgdGhlcmUncyBhIGN5Y2xpYyBoZWFkZXIgaW5jbHVk
aW5nLCB3aGljaCBsZWFkcyB0byB0aGlzIGJ1aWxkIGVycm9yLg0KPiA+IEkgY2hlY2tlZCBodHRw
czovL2dpdGh1Yi5jb20va3ZtLXJpc2N2L2xpbnV4L3RyZWUvbWFzdGVyIGFuZA0KPiA+IGh0dHBz
Oi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC90cmVlL21hc3RlciwgYnV0IEkgZG9uJ3Qgc2Vl
DQo+ID4gImFzbS9jcHVmZWF0dXJlLmgiIGlzIGluY2x1ZGVkIGluIGFzbS9od2NhcC5oOjkwLCBt
YXliZSBJIG1pc3MNCj4gc29tZXRoaW5nLA0KPiA+IGNvdWxkIHlvdSBoZWxwIHBvaW50IG1lIHRv
IHRoZSByZXBvL2JyYW5jaCBJIHNob3VsZCB3b3JrIG9uPw0KPiANCj4gRnJvbSBNQUlOVEFJTkVS
UzoNCj4gCVJJU0MtViBBUkNISVRFQ1RVUkUNCj4gCS4uLg0KPiAJVDoJZ2l0IGdpdDovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9yaXNjdi9saW51eC5naXQNCj4gDQo+
IFRoZSBmb3ItbmV4dCBicmFuY2ggdGhlcmUgaXMgd2hhdCB5b3Ugc2hvdWxkIGJlIGJhc2luZyB3
b3JrIG9uIHRvcCBvZi4NCj4gQUZBSUNULCB5b3UndmUgbWFkZSBiaXRvcHMuaCBpbmNsdWRlIGh3
Y2FwLmggd2hpbGUgY3B1ZmVhdHVyZS5oIGluY2x1ZGVzDQo+IGJvdGggYml0b3BzLmggKGluZGly
ZWN0bHkpIGFuZCBod2NhcC5oLg0KDQpUaGFua3MgZm9yIHRoZSBpbmZvLCBidXQgSSBjYW4ndCBy
ZXByb2R1Y2UgQW51cCdzIGJ1aWxkIGVycm9yIHdpdGggdGhpcyBmb3ItbmV4dCBicmFuY2gsIGNw
dWZlYXR1cmUuaCBpcyBub3QgaW5jbHVkZWQgYnkgaHdjYXAuaCB0aGVyZS4NCk1heWJlIEFudXAg
Y291bGQgaGVscCBkb3VibGUgY2hlY2sgdGhlIHRlc3QgZW52aXJvbm1lbnQ/DQoNCkJScywNClhp
YW8NCg0KDQo+IA0KPiBIb3BlIHRoYXQgaGVscHMsDQo+IENvbm9yLg0KPiANCj4gPiA+ICAgICAg
ICAgICAgICAgICAgZnJvbQ0KPiA+ID4gL2hvbWUvYW51cC9Xb3JrL3Jpc2N2LXRlc3QvbGludXgv
YXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9iaXRvcHMuaDoyNiwNCj4gPiA+ICAgICAgICAgICAgICAg
ICAgZnJvbQ0KPiA+ID4gL2hvbWUvYW51cC9Xb3JrL3Jpc2N2LXRlc3QvbGludXgvaW5jbHVkZS9s
aW51eC9iaXRvcHMuaDo2OCwNCj4gPiA+ICAgICAgICAgICAgICAgICAgZnJvbSAvaG9tZS9hbnVw
L1dvcmsvcmlzY3YtdGVzdC9saW51eC9pbmNsdWRlL2xpbnV4L2xvZzIuaDoxMiwNCj4gPiA+ICAg
ICAgICAgICAgICAgICAgZnJvbSAvaG9tZS9hbnVwL1dvcmsvcmlzY3YtdGVzdC9saW51eC9rZXJu
ZWwvYm91bmRzLmM6MTM6DQo+ID4gPiAvaG9tZS9hbnVwL1dvcmsvcmlzY3YtdGVzdC9saW51eC9p
bmNsdWRlL2xpbnV4L2ZpbmQuaDogSW4gZnVuY3Rpb24NCj4gPiA+ICdmaW5kX25leHRfYml0JzoN
Cj4gPiA+IC9ob21lL2FudXAvV29yay9yaXNjdi10ZXN0L2xpbnV4L2luY2x1ZGUvbGludXgvZmlu
ZC5oOjY0OjMwOiBlcnJvcjoNCj4gPiA+IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9u
ICdfX2ZmcycNCj4gPiA+IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQ0K
PiA+ID4gICAgNjQgfCAgICAgICAgICAgICAgICAgcmV0dXJuIHZhbCA/IF9fZmZzKHZhbCkgOiBz
aXplOw0KPiA+ID4NCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPiBBbnVwDQo+ID4gPg0KPiA+ID4NCj4g
PiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWGlhbyBXYW5nIDx4aWFvLncud2FuZ0BpbnRl
bC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9iaXRv
cHMuaCAgICAgICB8IDI2Ng0KPiArKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ID4gPiAg
ZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9NYWtlZmlsZSB8ICAgMiArLQ0KPiA+ID4gPiAg
MiBmaWxlcyBjaGFuZ2VkLCAyNjQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiA+
ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vYml0b3BzLmgN
Cj4gPiA+IGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9iaXRvcHMuaA0KPiA+ID4gPiBpbmRleCAz
NTQwYjY5MDk0NGIuLmY3MjdmNjQ4OWNkNSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvYXJjaC9yaXNj
di9pbmNsdWRlL2FzbS9iaXRvcHMuaA0KPiA+ID4gPiArKysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUv
YXNtL2JpdG9wcy5oDQo+ID4gPiA+IEBAIC0xNSwxMyArMTUsMjczIEBADQo+ID4gPiA+ICAjaW5j
bHVkZSA8YXNtL2JhcnJpZXIuaD4NCj4gPiA+ID4gICNpbmNsdWRlIDxhc20vYml0c3Blcmxvbmcu
aD4NCg==
