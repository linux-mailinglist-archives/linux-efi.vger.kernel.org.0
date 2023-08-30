Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749BF78D334
	for <lists+linux-efi@lfdr.de>; Wed, 30 Aug 2023 08:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbjH3GOr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Aug 2023 02:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239458AbjH3GO2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Aug 2023 02:14:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C21CCCB;
        Tue, 29 Aug 2023 23:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693376066; x=1724912066;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sUN5qOqpveyE99pLf26jAk30n4aAZmPhJF/pi0bZBZo=;
  b=VbZzht+GMKiF8Zn/zdN5sCSxh5vnp5VLmVAZI5umbFaGPXP0SHH59Oq1
   FSiMOY7RGvVfcRJSG1rmyPNcjWRJYOS80BNyfuQLgnTTOfp7f+amf1jQh
   h1eNw6J0Hy8b+irr7Dna+KttTRXTFiXJ43lTQYThFHyuaUOyKltN28quF
   AuXq5mleHwXfyEeckX+dkeKPa+JYiqARnfBIDkcxPlocL4tjr55O/ctho
   V+gWrLm5lKMVgk2OaI9m4pzSe+DbnyKUVF9xHQOAhs/uphCQ39crIXEnv
   5H3CGVLRrkoG/kRbY1A7vEr01k+TtJZpQstWxbhGnNp3YdknFHQ5nm02R
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="365762228"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="365762228"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 23:14:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="829109325"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="829109325"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Aug 2023 23:14:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 23:14:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 23:14:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 23:14:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 23:14:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6iUYBoiaeGhEpxRzWV5LhIlVSdfW1RtJchk7OUolTDrz2sOgxJXrRrWeEFzWFDhx3RoggXOnj4WXRwrWcE/mgRQVmIJDeFGg2z5MFAEoIh5Gp1HQezDZ/AIy206mmU/xrn5xcaNT+fEXfrQqnvnJkeU5exLLgR20Eeomeo5tbrBqsj2whhJaycsM1rvdFIpZ6kpIKuRQyV59SnHGOpumVuRXl8n4X6v7fIeDm1Y8b7Lp1hFMXoMy4qgphSOyRW/wYImLpodJOr6WB+Z0v0A4S2HtSQF6/ZWEkpr0H5jZj7Y4PI3T6eHZdT2Qb+IfE3bPb6Pcww7VUIsFG6RE1ReBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUN5qOqpveyE99pLf26jAk30n4aAZmPhJF/pi0bZBZo=;
 b=A4wQRxq42b/g4gwqce3ZRN9nnOGLF6PneQD+GzS1T2usJdUWLOIgE9/GKdoDqZmNkDcZ0NBy85yRvsn9spe3EVUZv2asIfve8SzQC070EKUlT75KgMfSJlDZh9Rw+iaQsyb50ruE+n3DWmxgSvwTSw8V3Lwm3f0fAZwXtE4SCV0Jec4yW0WYf/8J2UAf4Y5waIk2v2uyntEztmZBDEoHkrct3elJkTSwRhD9SMdc9q1nZHtMT+3a4bK0O6LMzNa1TjFgmyeBpJUDHBVSYJzSg2n4289IyqEcColupo2xw7QtIZ4+Spdl/cKtVoDS5og7d9bvdGPRiGTZ2PCc4I9S6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 SJ0PR11MB8270.namprd11.prod.outlook.com (2603:10b6:a03:479::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 06:14:12 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531%3]) with mapi id 15.20.6745.015; Wed, 30 Aug 2023
 06:14:12 +0000
From:   "Wang, Xiao W" <xiao.w.wang@intel.com>
To:     Anup Patel <anup@brainfault.org>
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
Thread-Index: AQHZyA83tlYFgJbtxEiuzFgm3vAb3bABQgqAgAE4pIA=
Date:   Wed, 30 Aug 2023 06:14:12 +0000
Message-ID: <DM8PR11MB57512001CAFA07EC58203A7BB8E6A@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20230806024715.3061589-1-xiao.w.wang@intel.com>
 <CAAhSdy2_djw2JX+8tmF2V190+x9KLvt7u8rCX-TaGCKQrUVOYQ@mail.gmail.com>
In-Reply-To: <CAAhSdy2_djw2JX+8tmF2V190+x9KLvt7u8rCX-TaGCKQrUVOYQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|SJ0PR11MB8270:EE_
x-ms-office365-filtering-correlation-id: f345c041-bc23-4bad-d7ec-08dba92054a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0FBQtLNrFapGI59JskIsnADsyFUpltUK1eRrmZMSxChBekf5Rolb6tl18pPc/0hmvL/qmXH7RyvNHijOE5cZstI0MOlyvHjVtGAbJQSCG96k2EP+svj14/uXLHs22JJL8L2l16DNCmXZJ5y/NShk/IxUueE6BFE73N0qseWUD36YAojdIyPrqcrYLLsKl6HTEHEyFLKaPEj0DAcatrOkkUTC+atMTtdqAr9843vzVHFCaKhJLeU7wl8hHcTGJfQyszp69TZbQDVOUte6zDx+2C3dxVuCHFlNIV86Fhvz4ulabAJmM7Cm7RDwQEYwo7q9BixNPBnleeXGEOyd1Egf7jCcKGPh33rq3W3McHqApgPmJHavFYhnh4K+hK5DeuiSGvysd8dFwLZGoKni3EhMilbnQLxvXxWj1HlluN85GYPB6CZtRe63TgZSnRiJyHp8h1CO/j58iyePmfgUU2N038AF1SGitwKMom7ArA3Zm2P26MsPpmgtHMW0PBUtLdfzzRiPiAHd1Qu0SJlyv4CpqYHxvN//xEID7ZEh1rZjH4EVsICyyJWlFe07QzzIJYtpB6QVoGTmz68E5moSzqCa5A7Bp6s/gioOvPLrF7nSFHQiUdFdb0Q2sX2bumW48SkzUDv3Xu86WM4dnhhtxFQESA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(186009)(1800799009)(451199024)(6506007)(9686003)(7696005)(71200400001)(966005)(76116006)(478600001)(83380400001)(53546011)(26005)(2906002)(52536014)(4326008)(316002)(66556008)(6916009)(66946007)(8936002)(54906003)(41300700001)(64756008)(8676002)(66476007)(5660300002)(66446008)(33656002)(55016003)(86362001)(122000001)(38100700002)(38070700005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WitDa3FJa3NSbTR5cU56Y0llZUJlT3RReU55N28xMHlQaDF1Qmc5dzVJRThB?=
 =?utf-8?B?N3pSZWxqRDZLRHdZbjlKbm5oc2trcGZKL0dJTnNtek1lMEQzN1ZXbk52Zkh2?=
 =?utf-8?B?eTF0dEhQWktSa1ZVL1grc1VZWFBFb0U5Qk5QS2Ribkd2UzFkakVQV2tsVHZ4?=
 =?utf-8?B?ZGxaYlRHMktIeDluMEprMDlTRW4wZk1rKzkwQTFBbVZGTGoxVjlKaFZFclJm?=
 =?utf-8?B?NEJQRjJTeXV3RThJNmZWY3d6UTM2ZlluZG9mZk9tK3JLeVFjNkZocnRoWHJ6?=
 =?utf-8?B?WTRmR3cvT3NBOGVVaWRSbDQ0cVJrb1I5TE03Yyt1TFhib21KQm0wOE5VcnhQ?=
 =?utf-8?B?V3YrbU9vbFJRRkd1TFpzZzFoNHJnL1V1bERNUkxUWkxZN1h5UHpwWTl0Z0Fm?=
 =?utf-8?B?a0hURTBNSlpVNGZRMStKbEdWZmdqWW5iL1dmZEtHU2JQVHZHK3Nzc3lRL1k1?=
 =?utf-8?B?MVY3MXdCdVdacU1OdVRzSnh1bDlleVl2N1ozMGpxTXVoRXJLWHV0NFI3NFlX?=
 =?utf-8?B?c2xuT0J5M2VxNXdmaGYrekFzdGtzYnNQMUVESTN4cUwxWmRDODIrU0ZJMUFt?=
 =?utf-8?B?SmZQUGNhUy9qUVNqOHJpaWZGNUNITXZQdW1lbWk5U1ZkQkNCaUlpMk5vajY1?=
 =?utf-8?B?K0VENTlaTnJncVJjVG55SzJVY0RWeVE4SEVib0p3WDd2OHFxWXUvdktMbmZU?=
 =?utf-8?B?SFF4eW9uSUwvaVdDS08wcEJtT3ZkR2JjWVhHeWc1N3RYa1owcmFwa1I5clJ2?=
 =?utf-8?B?VjE1WEpsVnlHZm5WZHk2VWhoanJ1MUdyeWpCeU9LcjBaRk5PaEc5bHJNWFho?=
 =?utf-8?B?K05GaEFJcmw1QTJneSthZm9OWkx0enNJMmZOb1lLZTZZSGJOc2hxcDJMK1Qy?=
 =?utf-8?B?WG9XcEFUd1hJUFcxeU9OYkh4bEVuWm15UitUdE5TdDliQ1hKaW4wV0EySlc2?=
 =?utf-8?B?UFgyc0ZEUnhZbE15ZUlNemRLU2ZlMG01djM3bjUyZTFtMnJXQjJMTEowSHEy?=
 =?utf-8?B?aTE4L0p1dkZGWitRdzFYeElKMkxDeWhSV2NyTzNjdWtSZU51TWU4TG1HRm5Y?=
 =?utf-8?B?RlhHNTc5c0loMmRvM1h6Q3hSK29XeUR4ZzVKdWVDaUVwTG15NWVOeFh4OVRq?=
 =?utf-8?B?R2FqZmNxTWROeFR4YUZDWmZDTjZVYndYVTZaVnFjb3pZc0dIUElndGpvK1Fi?=
 =?utf-8?B?NFd1aytUelg3QWl1elN5NGlPV3gyaDZ2aFp2elVIcVkwYmRMUjQrZFcxSmE0?=
 =?utf-8?B?bzBWSkhvTi9UcWhMNVZYWGpxenRsYkIzU3RsZk5vMTRucXhnSnY4cUhuUEli?=
 =?utf-8?B?KzVWSWJvWEJzb1VueHpUNUtTSjFNbUwzVFNmaXhnMTJid3RjQVhCb0lUbHVD?=
 =?utf-8?B?dXM5aTZvTy9zUnhUZWF3SVgwZ0l5ZEsrMjlPcm5rUEY1bGNIMkhPQ0ZRRFJH?=
 =?utf-8?B?UnRGd1Nud1NPcFVMcUZKK29VeWdzK0ViZTZzclVkS3ZQNWM4M0FQRmlUWE05?=
 =?utf-8?B?QVpmMFRHVlBhM1pEWVI1WDJkM3JVb2MxcmpWd0l5SWt4SjZpQitNd2VVV0Y0?=
 =?utf-8?B?Vyt5SUk3SWRSQ0pSUEhiSFFoaDBscGVYcGNMVWthdDJXalQ3WWxNa0V1bzU0?=
 =?utf-8?B?d25GRkJJNlpsb1JPc0hzMjI4U29CWDNyWERpQjh4TmNXd2dxN09BVTV1Rlk2?=
 =?utf-8?B?U3R3Qk9hOURlRGc3dzlpY3R2OURLeTV3UGJLS2hjRFFNL04zNkc1elh4ZkxH?=
 =?utf-8?B?UWJZcWw1MFAwRDhtcGFNcDlnNDEyejMvZ0NKZWpQTVFtcEJJMW9paVkzZXZh?=
 =?utf-8?B?dUZ3aVNTbnE1ZHJFVDYrQnE3UFhLMVh6dzdVRDUrUk4zSjVxWmdBVGJhQ1pL?=
 =?utf-8?B?YkljT2NpbDFwNkhIaUJQZCtieHZRTDY3MHRsWVhIcHBBTjMxVk5EYmhmQ1ZF?=
 =?utf-8?B?L2s4akpwcWF1bCtuUXJaRVRQN0RqRG1aUWdsblIvdjNNZE1kZEpiUlB6YWtC?=
 =?utf-8?B?LzhLSjdDcHVhR2hlVFYvaWlic0Jpb2hjdXBrSE13NkVmSDFTMWhvMGhEdTJ3?=
 =?utf-8?B?cGNwTVVyNDlmdGRrWS9STHlrVHc2bTI0SVJoMm1ua0NHS1U1NS80VEFEaVNB?=
 =?utf-8?Q?7wImTe/qlwczx8IB/1WiU92nd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f345c041-bc23-4bad-d7ec-08dba92054a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 06:14:12.7059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ulZC46JTNE5zUVPeti0WstkJhv3SHrAWkxV5bVEBRJAmhPbzCTP3mkh4kctkqsiMfmM8Vm3JwOGJLIOHey4Tsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8270
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW51cCBQYXRlbCA8
YW51cEBicmFpbmZhdWx0Lm9yZz4NCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDI5LCAyMDIzIDc6
MDggUE0NCj4gVG86IFdhbmcsIFhpYW8gVyA8eGlhby53LndhbmdAaW50ZWwuY29tPg0KPiBDYzog
cGF1bC53YWxtc2xleUBzaWZpdmUuY29tOyBwYWxtZXJAZGFiYmVsdC5jb207DQo+IGFvdUBlZWNz
LmJlcmtlbGV5LmVkdTsgYXJkYkBrZXJuZWwub3JnOyBMaSwgSGFpY2hlbmcNCj4gPGhhaWNoZW5n
LmxpQGludGVsLmNvbT47IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0K
PiBlZmlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIFJJU0MtVjogT3B0aW1pemUgYml0b3BzIHdpdGggWmJiIGV4dGVu
c2lvbg0KPiANCj4gT24gU3VuLCBBdWcgNiwgMjAyMyBhdCA4OjA54oCvQU0gWGlhbyBXYW5nIDx4
aWFvLncud2FuZ0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBsZXZlcmFn
ZXMgdGhlIGFsdGVybmF0aXZlIG1lY2hhbmlzbSB0byBkeW5hbWljYWxseSBvcHRpbWl6ZQ0KPiA+
IGJpdG9wcyAoaW5jbHVkaW5nIF9fZmZzLCBfX2ZscywgZmZzLCBmbHMpIHdpdGggWmJiIGluc3Ry
dWN0aW9ucy4gV2hlbg0KPiA+IFpiYiBleHQgaXMgbm90IHN1cHBvcnRlZCBieSB0aGUgcnVudGlt
ZSBDUFUsIGxlZ2FjeSBpbXBsZW1lbnRhdGlvbiBpcw0KPiA+IHVzZWQuIElmIFpiYiBpcyBzdXBw
b3J0ZWQsIHRoZW4gdGhlIG9wdGltaXplZCB2YXJpYW50cyB3aWxsIGJlIHNlbGVjdGVkDQo+ID4g
dmlhIGFsdGVybmF0aXZlIHBhdGNoaW5nLg0KPiA+DQo+ID4gVGhlIGxlZ2FjeSBiaXRvcHMgc3Vw
cG9ydCBpcyB0YWtlbiBmcm9tIHRoZSBnZW5lcmljIEMgaW1wbGVtZW50YXRpb24gYXMNCj4gPiBm
YWxsYmFjay4NCj4gPg0KPiA+IElmIHRoZSBwYXJhbWV0ZXIgaXMgYSBidWlsZC10aW1lIGNvbnN0
YW50LCB3ZSBsZXZlcmFnZSBjb21waWxlciBidWlsdGluIHRvDQo+ID4gY2FsY3VsYXRlIHRoZSBy
ZXN1bHQgZGlyZWN0bHksIHRoaXMgYXBwcm9hY2ggaXMgaW5zcGlyZWQgYnkgeDg2IGJpdG9wcw0K
PiA+IGltcGxlbWVudGF0aW9uLg0KPiA+DQo+ID4gRUZJIHN0dWIgcnVucyBiZWZvcmUgdGhlIGtl
cm5lbCwgc28gYWx0ZXJuYXRpdmUgbWVjaGFuaXNtIHNob3VsZCBub3QgYmUNCj4gPiB1c2VkIHRo
ZXJlLCB0aGlzIHBhdGNoIGludHJvZHVjZXMgYSBtYWNybyBFRklfTk9fQUxURVJOQVRJVkUgZm9y
IHRoaXMNCj4gPiBwdXJwb3NlLg0KPiANCj4gSSBhbSBnZXR0aW5nIHRoZSBmb2xsb3dpbmcgY29t
cGlsZSBlcnJvciB3aXRoIHRoaXMgcGF0Y2g6DQo+IA0KPiAgIEdFTiAgICAgTWFrZWZpbGUNCj4g
ICBVUEQgICAgIGluY2x1ZGUvY29uZmlnL2tlcm5lbC5yZWxlYXNlDQo+ICAgVVBEICAgICBpbmNs
dWRlL2dlbmVyYXRlZC91dHNyZWxlYXNlLmgNCj4gICBDQyAgICAgIGtlcm5lbC9ib3VuZHMucw0K
PiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gL2hvbWUvYW51cC9Xb3JrL3Jpc2N2LQ0KPiB0ZXN0L2xp
bnV4L2luY2x1ZGUvbGludXgvYml0bWFwLmg6OSwNCj4gICAgICAgICAgICAgICAgICBmcm9tDQo+
IC9ob21lL2FudXAvV29yay9yaXNjdi10ZXN0L2xpbnV4L2FyY2gvcmlzY3YvaW5jbHVkZS9hc20v
Y3B1ZmVhdHVyZS5oOjksDQo+ICAgICAgICAgICAgICAgICAgZnJvbQ0KPiAvaG9tZS9hbnVwL1dv
cmsvcmlzY3YtdGVzdC9saW51eC9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2h3Y2FwLmg6OTAsDQoN
Cg0KSXQgbG9va3MgdGhlcmUncyBhIGN5Y2xpYyBoZWFkZXIgaW5jbHVkaW5nLCB3aGljaCBsZWFk
cyB0byB0aGlzIGJ1aWxkIGVycm9yLg0KSSBjaGVja2VkIGh0dHBzOi8vZ2l0aHViLmNvbS9rdm0t
cmlzY3YvbGludXgvdHJlZS9tYXN0ZXIgYW5kIGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9s
aW51eC90cmVlL21hc3RlciwgYnV0IEkgZG9uJ3Qgc2VlICJhc20vY3B1ZmVhdHVyZS5oIiBpcyBp
bmNsdWRlZCBpbiBhc20vaHdjYXAuaDo5MCwgbWF5YmUgSSBtaXNzIHNvbWV0aGluZywgY291bGQg
eW91IGhlbHAgcG9pbnQgbWUgdG8gdGhlIHJlcG8vYnJhbmNoIEkgc2hvdWxkIHdvcmsgb24/DQoN
ClRoYW5rcywNClhpYW8NCg0KPiAgICAgICAgICAgICAgICAgIGZyb20NCj4gL2hvbWUvYW51cC9X
b3JrL3Jpc2N2LXRlc3QvbGludXgvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9iaXRvcHMuaDoyNiwN
Cj4gICAgICAgICAgICAgICAgICBmcm9tDQo+IC9ob21lL2FudXAvV29yay9yaXNjdi10ZXN0L2xp
bnV4L2luY2x1ZGUvbGludXgvYml0b3BzLmg6NjgsDQo+ICAgICAgICAgICAgICAgICAgZnJvbSAv
aG9tZS9hbnVwL1dvcmsvcmlzY3YtdGVzdC9saW51eC9pbmNsdWRlL2xpbnV4L2xvZzIuaDoxMiwN
Cj4gICAgICAgICAgICAgICAgICBmcm9tIC9ob21lL2FudXAvV29yay9yaXNjdi10ZXN0L2xpbnV4
L2tlcm5lbC9ib3VuZHMuYzoxMzoNCj4gL2hvbWUvYW51cC9Xb3JrL3Jpc2N2LXRlc3QvbGludXgv
aW5jbHVkZS9saW51eC9maW5kLmg6IEluIGZ1bmN0aW9uDQo+ICdmaW5kX25leHRfYml0JzoNCj4g
L2hvbWUvYW51cC9Xb3JrL3Jpc2N2LXRlc3QvbGludXgvaW5jbHVkZS9saW51eC9maW5kLmg6NjQ6
MzA6IGVycm9yOg0KPiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnX19mZnMnDQo+
IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQ0KPiAgICA2NCB8ICAgICAg
ICAgICAgICAgICByZXR1cm4gdmFsID8gX19mZnModmFsKSA6IHNpemU7DQo+IA0KPiBSZWdhcmRz
LA0KPiBBbnVwDQo+IA0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFhpYW8gV2FuZyA8eGlh
by53LndhbmdAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNt
L2JpdG9wcy5oICAgICAgIHwgMjY2ICsrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gIGRy
aXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvTWFrZWZpbGUgfCAgIDIgKy0NCj4gPiAgMiBmaWxl
cyBjaGFuZ2VkLCAyNjQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2JpdG9wcy5oDQo+IGIvYXJjaC9yaXNj
di9pbmNsdWRlL2FzbS9iaXRvcHMuaA0KPiA+IGluZGV4IDM1NDBiNjkwOTQ0Yi4uZjcyN2Y2NDg5
Y2Q1IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vYml0b3BzLmgNCj4g
PiArKysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2JpdG9wcy5oDQo+ID4gQEAgLTE1LDEzICsx
NSwyNzMgQEANCj4gPiAgI2luY2x1ZGUgPGFzbS9iYXJyaWVyLmg+DQo+ID4gICNpbmNsdWRlIDxh
c20vYml0c3BlcmxvbmcuaD4NCj4gPg0KPiA+ICsjaWYgIWRlZmluZWQoQ09ORklHX1JJU0NWX0lT
QV9aQkIpIHx8IGRlZmluZWQoRUZJX05PX0FMVEVSTkFUSVZFKQ0KPiA+ICAjaW5jbHVkZSA8YXNt
LWdlbmVyaWMvYml0b3BzL19fZmZzLmg+DQo+ID4gLSNpbmNsdWRlIDxhc20tZ2VuZXJpYy9iaXRv
cHMvZmZ6Lmg+DQo+ID4gLSNpbmNsdWRlIDxhc20tZ2VuZXJpYy9iaXRvcHMvZmxzLmg+DQo+ID4g
ICNpbmNsdWRlIDxhc20tZ2VuZXJpYy9iaXRvcHMvX19mbHMuaD4NCj4gPiArI2luY2x1ZGUgPGFz
bS1nZW5lcmljL2JpdG9wcy9mZnMuaD4NCj4gPiArI2luY2x1ZGUgPGFzbS1nZW5lcmljL2JpdG9w
cy9mbHMuaD4NCj4gPiArDQo+ID4gKyNlbHNlDQo+ID4gKyNpbmNsdWRlIDxhc20vYWx0ZXJuYXRp
dmUtbWFjcm9zLmg+DQo+ID4gKyNpbmNsdWRlIDxhc20vaHdjYXAuaD4NCj4gPiArDQo+ID4gKyNp
ZiAoQklUU19QRVJfTE9ORyA9PSA2NCkNCj4gPiArI2RlZmluZSBDVFpXICAgImN0encgIg0KPiA+
ICsjZGVmaW5lIENMWlcgICAiY2x6dyAiDQo+ID4gKyNlbGlmIChCSVRTX1BFUl9MT05HID09IDMy
KQ0KPiA+ICsjZGVmaW5lIENUWlcgICAiY3R6ICINCj4gPiArI2RlZmluZSBDTFpXICAgImNseiAi
DQo+ID4gKyNlbHNlDQo+ID4gKyNlcnJvciAiVW5leHBlY3RlZCBCSVRTX1BFUl9MT05HIg0KPiA+
ICsjZW5kaWYNCj4gPiArDQo+ID4gK3N0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdW5zaWduZWQgbG9u
ZyB2YXJpYWJsZV9fZmZzKHVuc2lnbmVkIGxvbmcgd29yZCkNCj4gPiArew0KPiA+ICsgICAgICAg
aW50IG51bTsNCj4gPiArDQo+ID4gKyAgICAgICBhc21fdm9sYXRpbGVfZ290bygNCj4gPiArICAg
ICAgICAgICAgICAgQUxURVJOQVRJVkUoImogJWxbbGVnYWN5XSIsICJub3AiLCAwLCBSSVNDVl9J
U0FfRVhUX1pCQiwgMSkNCj4gPiArICAgICAgICAgICAgICAgOiA6IDogOiBsZWdhY3kpOw0KPiA+
ICsNCj4gPiArICAgICAgIGFzbSB2b2xhdGlsZSAoDQo+ID4gKyAgICAgICAgICAgICAgICIub3B0
aW9uIHB1c2hcbiINCj4gPiArICAgICAgICAgICAgICAgIi5vcHRpb24gYXJjaCwremJiXG4iDQo+
ID4gKyAgICAgICAgICAgICAgICJjdHogJTAsICUxXG4iDQo+ID4gKyAgICAgICAgICAgICAgICIu
b3B0aW9uIHBvcFxuIg0KPiA+ICsgICAgICAgICAgICAgICA6ICI9ciIgKHdvcmQpIDogInIiICh3
b3JkKSA6KTsNCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gd29yZDsNCj4gPiArDQo+ID4gK2xl
Z2FjeToNCj4gPiArICAgICAgIG51bSA9IDA7DQo+ID4gKyNpZiBCSVRTX1BFUl9MT05HID09IDY0
DQo+ID4gKyAgICAgICBpZiAoKHdvcmQgJiAweGZmZmZmZmZmKSA9PSAwKSB7DQo+ID4gKyAgICAg
ICAgICAgICAgIG51bSArPSAzMjsNCj4gPiArICAgICAgICAgICAgICAgd29yZCA+Pj0gMzI7DQo+
ID4gKyAgICAgICB9DQo+ID4gKyNlbmRpZg0KPiA+ICsgICAgICAgaWYgKCh3b3JkICYgMHhmZmZm
KSA9PSAwKSB7DQo+ID4gKyAgICAgICAgICAgICAgIG51bSArPSAxNjsNCj4gPiArICAgICAgICAg
ICAgICAgd29yZCA+Pj0gMTY7DQo+ID4gKyAgICAgICB9DQo+ID4gKyAgICAgICBpZiAoKHdvcmQg
JiAweGZmKSA9PSAwKSB7DQo+ID4gKyAgICAgICAgICAgICAgIG51bSArPSA4Ow0KPiA+ICsgICAg
ICAgICAgICAgICB3b3JkID4+PSA4Ow0KPiA+ICsgICAgICAgfQ0KPiA+ICsgICAgICAgaWYgKCh3
b3JkICYgMHhmKSA9PSAwKSB7DQo+ID4gKyAgICAgICAgICAgICAgIG51bSArPSA0Ow0KPiA+ICsg
ICAgICAgICAgICAgICB3b3JkID4+PSA0Ow0KPiA+ICsgICAgICAgfQ0KPiA+ICsgICAgICAgaWYg
KCh3b3JkICYgMHgzKSA9PSAwKSB7DQo+ID4gKyAgICAgICAgICAgICAgIG51bSArPSAyOw0KPiA+
ICsgICAgICAgICAgICAgICB3b3JkID4+PSAyOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsgICAgICAg
aWYgKCh3b3JkICYgMHgxKSA9PSAwKQ0KPiA+ICsgICAgICAgICAgICAgICBudW0gKz0gMTsNCj4g
PiArICAgICAgIHJldHVybiBudW07DQo+ID4gK30NCj4gPiArDQo+ID4gKy8qKg0KPiA+ICsgKiBf
X2ZmcyAtIGZpbmQgZmlyc3Qgc2V0IGJpdCBpbiBhIGxvbmcgd29yZA0KPiA+ICsgKiBAd29yZDog
VGhlIHdvcmQgdG8gc2VhcmNoDQo+ID4gKyAqDQo+ID4gKyAqIFVuZGVmaW5lZCBpZiBubyBzZXQg
Yml0IGV4aXN0cywgc28gY29kZSBzaG91bGQgY2hlY2sgYWdhaW5zdCAwIGZpcnN0Lg0KPiA+ICsg
Ki8NCj4gPiArI2RlZmluZSBfX2Zmcyh3b3JkKSAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
DQo+ID4gKyAgICAgICAoX19idWlsdGluX2NvbnN0YW50X3Aod29yZCkgPyAgICAgICAgICAgXA0K
PiA+ICsgICAgICAgICh1bnNpZ25lZCBsb25nKV9fYnVpbHRpbl9jdHpsKHdvcmQpIDogIFwNCj4g
PiArICAgICAgICB2YXJpYWJsZV9fZmZzKHdvcmQpKQ0KPiA+ICsNClsuLi5dDQo=
