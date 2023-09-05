Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402BA792A4C
	for <lists+linux-efi@lfdr.de>; Tue,  5 Sep 2023 18:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244018AbjIEQeo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 5 Sep 2023 12:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354557AbjIEMiT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 5 Sep 2023 08:38:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAEB1A8;
        Tue,  5 Sep 2023 05:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693917496; x=1725453496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lLSXtlClZagX6ZCk7H6suaXxTJEjeRJANz5kwCaAP78=;
  b=MEzkULfB2Z5dvbOMTqxQEZQjkdzIcQVQPGmS4IfZKlS7C8zQLAjTyqd8
   F953qZShAW17n6DVxTGNwl81+P1uPQLgESAdgdbHn8pu7Jb4T24S6wayp
   ElB/JiV+GlUTyWgoUoWLJ7v2rASi+JIEf1iIKq7xP9SbSLD7dXdcLQwPR
   5uF2jcU9ROA4p8L60RlnNBnSnvSKab2OSGCL0n4M5TPec4CAIz/sW0DY2
   +S0//qYanm8SzL5Lglx/KVuVft66KJS77k6QyQYJnL5SSlVymJthGfKig
   mg6vzuvyOyytgZKsnoZs9sIEa0URXbwXRD3JPU57ut1I2zO/xmymJAaxD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="374172692"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="374172692"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 05:38:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="690917114"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="690917114"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 05:38:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 05:38:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 05:38:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 05:38:14 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 05:38:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdKYW4pGud4q2bGB+8UG+PPRwjRLmNv2/+5YXScjNMic9YfBx5Xxg5nirRXQF2hR4ClpZSf1xjeBtwIUmwJ5CtxBig9clOa8ymRx7swNgE98R85nrZnMvbLiSyjZ0NNttbGZb7M799g6mfPGn0JafkcJeWFey+htvynMLXuftwZ2C+1n4KZh+5G4ejAPaJv0nToCmPQ4vYKuGWMfVqgHihquXBQtDR3HCdj2Vr9abJxoeWT0zvNOYmSFq7hOPt/NyvtqITv06jXuqVX8Q5C+CJM6o2Ne84Qe7pOkp4mimT5F8Bmmk/1Log/Aj03Z75pHshgLXykZ00SCnECVkstVKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLSXtlClZagX6ZCk7H6suaXxTJEjeRJANz5kwCaAP78=;
 b=QlLHSMZAimI3Mog6PgJewaRPgQJSzk1lR5h9TmBsCvas4XnGKOIUtYbNxzgwfVTLT1FbyCc2mrtBNtel9eqBPeiRQ/qgBDwTcoPomkQe4i9QoDJCp9U9jBChhuYHe97Yw2i6r0DsHZYDGlmRJJP9f356TVoYtajSbgZ1eHP611+b06/JEmV60YGtdW2pxVLbM8hoHOF90xlbRraZzmRsX4cCo1zmk0ZZKMqvCFsx3U6m1Ltz2joUpoNW4H3vnbboEEHIv/hgkwgOIfgsAk0+Pg6QohzKJg245KHsR352HvcJYTBGJ6QsRpj3UzADwCU9SKsgHqwFuSXr831wS8Vm7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 SA3PR11MB7654.namprd11.prod.outlook.com (2603:10b6:806:305::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 12:38:12 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 12:38:12 +0000
From:   "Wang, Xiao W" <xiao.w.wang@intel.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "Li, Haicheng" <haicheng.li@intel.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RISC-V: Optimize bitops with Zbb extension
Thread-Topic: [PATCH] RISC-V: Optimize bitops with Zbb extension
Thread-Index: AQHZyA83tlYFgJbtxEiuzFgm3vAb3bABQgqAgAE4pICAABQygIACJNYwgAAGqACAAA6zgIAHX5EwgAAPkQCAACJr0A==
Date:   Tue, 5 Sep 2023 12:38:12 +0000
Message-ID: <DM8PR11MB57517655040B0EBFC5DB38A6B8E8A@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20230806024715.3061589-1-xiao.w.wang@intel.com>
 <CAAhSdy2_djw2JX+8tmF2V190+x9KLvt7u8rCX-TaGCKQrUVOYQ@mail.gmail.com>
 <DM8PR11MB57512001CAFA07EC58203A7BB8E6A@DM8PR11MB5751.namprd11.prod.outlook.com>
 <20230830-breeze-washboard-ef496d5c9d5a@wendy>
 <DM8PR11MB575116E5EE183D7D41361B74B8E5A@DM8PR11MB5751.namprd11.prod.outlook.com>
 <CAK9=C2XTS539ew_rty6_MOwyZkdBBbGBCzxp33u1UpMP5STAqQ@mail.gmail.com>
 <20230831-f0f847c5703875f1e67635c1@orel>
 <DM8PR11MB5751CDA12CB037C678F1B829B8E8A@DM8PR11MB5751.namprd11.prod.outlook.com>
 <20230905-d4d7b1944ac3487156ce4f5c@orel>
In-Reply-To: <20230905-d4d7b1944ac3487156ce4f5c@orel>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|SA3PR11MB7654:EE_
x-ms-office365-filtering-correlation-id: a0aefb92-035c-447d-52ad-08dbae0cf7b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PagQRo8yT0oEVugYSZAylkghGyL6MzWgcgcIDv08eIvpvx4bPQ4bJvpSk0gEyCywDTXx0EZRxcesWiEBzjWcFrrRZBPAUAszz1zWX5uY5ok0HriKC1w3QgPXTl9CzEoZtW9K7+zmHkx80Xqj/szXEwMdZrrCjBfF87BGw+rzrEh/tB/5QGR9xr150DR65/rCDQcYqfITqhvYKCYUeyr5tQuIfwBNca3zPuHStJ0WqQM2xPbg5IikdPN3Gnjn7QZ2dfnNj1nsQ7TfJkl2ukZmCnFWE6826nugLNpzAJvam/DBQIkEjbjkN0+63cATRRJwCFuvbfwtLA77He7GRPNRJWSltTdMqvcw9IM2TP1wjhX7QcjOF8ZlqEJfDkej2MvfQXx3qDJpO/MKaTSLoabboFPKpRjdRDYIjdr9EKTqumZZyHlcHPi67OvH1Q7UY1Q3EoSzrNbef2/7D1KivibdDw2A8817GDcJiNUwmB+s/mSFHpmaS8YvmjIYf1ayDADPWRmahE12W78OCj33Q3+1MmmsUiiudksjZV0w56NzbD6Olb6ovR2abMFWNtVxPMPdhhp55l5Tnt8lPzvuRGVInkP1HTAb8bDHaeC0GvSjDTlTnrBSAotvk9ALWG5RroFtCE+HCDsLPLItLHoAtV1IRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(136003)(39860400002)(186009)(1800799009)(451199024)(7416002)(41300700001)(33656002)(122000001)(71200400001)(86362001)(82960400001)(966005)(38070700005)(478600001)(83380400001)(38100700002)(26005)(9686003)(6506007)(7696005)(53546011)(55016003)(76116006)(66946007)(2906002)(6916009)(54906003)(64756008)(316002)(66476007)(66556008)(66446008)(8936002)(8676002)(5660300002)(4326008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cit2N1dCUTBNMWVTdTdPc2ZiVStFRVRCODlyY0svNmlieVA3L3gvZUtFd0sz?=
 =?utf-8?B?QjVOZU1qemE3dTRucnFQUmFTWDZ2cUtrc1FXQ0RSdUZ5S252ZG1wMlJuVGxH?=
 =?utf-8?B?THMzTGpHNjQ1VS90dDBXWGJXZjZvQlpCbkhsczRXeTdoTUpMK2t3dUVnTmZ5?=
 =?utf-8?B?ajJjbkpvMjVvbi9JZENzVUVXd2hkNVNOZTB6Mkw3ek9Uck5ZVDJRUzNDZTVO?=
 =?utf-8?B?ZEJUY3F5VkNtRnQ2NTlrWmhGc3R0Qjl6K1JVVW55RkNPWmtHcmJPYW1DQnRz?=
 =?utf-8?B?QmdsVldPVWtjYkhPTFVmakNZTGdmMnR0Mnpucml5b0xXTzcrM0pKd2Rjc2Jl?=
 =?utf-8?B?Vk5OV1ZIUmhicHJTSnFtMjhvUHdWa0JDTjlRQVhQMy9YMmFycUc5ZDBkanJM?=
 =?utf-8?B?aGdxa3RMZ1VtRThqOUREUUpqVndvZFBVdFZGd1VmZy9YNmoyNG5pb1RBVE8x?=
 =?utf-8?B?bnJDN1VhaHlDV0NHOVNXblFZZkQvaCt5MTZXWDlaYWhETlppSm84UmVhZlFu?=
 =?utf-8?B?Wlh3V2htdjNBRjJiVjdpeFlXbERLOVFEd2c2akN4MkNnUFl3VzBZeTZnUkJp?=
 =?utf-8?B?NnRHZGxyNnBqR0luVnRzMTVYYU9oM3hVTFFHSDdNZUlOeGFTdVVtblZPZENR?=
 =?utf-8?B?VURMSEI1MkZFdEk0YXA4WDViNE5obUZIZFV0YkJDY3dtRm4ycHNqL3N5aUE0?=
 =?utf-8?B?djRlV2JwSDFJcHFvcGVEb1hHbm9HbTdCQlUwUHloRTc3NW1TeGxoMm5lMXNB?=
 =?utf-8?B?blpROUtpa3pqMlZ4VDUvblF3SU5PODgzcGg4dzVwSU5WSnRmOEx3Z1cxaTlX?=
 =?utf-8?B?SERJcjBoc0JQVHZSUnlHbDU3TVBMZExZQ1lFTmhVRE1rK2o5YTNqTy9TbjZ3?=
 =?utf-8?B?ODk3UHc5Q2NLNEJ2aXNUeEJrSSt2dnh2NzRDTVZtOXoreGN4REF4d20wMHNY?=
 =?utf-8?B?UTE3elg5S2x4anpCT0hNM3hMWW83ZXVXaDRnQm0zZmRDdnAvQ0FwZE1GMEk0?=
 =?utf-8?B?SVBuK3BBanlibEViLzQ4NndvMVBCTyswSTJFR2VWZ0RDUmxORXRYZ05BTk1i?=
 =?utf-8?B?d1AzZ0pQVEN3cXBXZnhLNzNGeUloZlhLdmRmbElDUitITUZzb1hYVGpMQk5X?=
 =?utf-8?B?UlptRjRRVHpBTm9MUGZvT011SnNnd1NmWXNIQzB0R3lBaFlkdXNld1lyRlhC?=
 =?utf-8?B?eGxSWGhFSUN3QkEvWHhGdlBKTXFFNHNiM2R1VDhsZFNrd3RJcUdobGsrTS9z?=
 =?utf-8?B?REsvNG41S0g5TEhNVEMxS2tlM3E5Q1ZWTW9nZkRyeW0ydEsvZXVtREk0ckFC?=
 =?utf-8?B?WFZhUGlFKy8wTEdkSlMzVmFxc2ZiZ2dobGNLc3I4c2MyRXhVQUtJU0I0VUhk?=
 =?utf-8?B?WHd1SEtpRlB5b2hSdEtqMjhreW94VWNuYVgwWmxqZHBrNGg3clFucGY1cDVP?=
 =?utf-8?B?NnlxaFp6ajVzUFVmVitBSE5MdFBFZE54bUxtUkRXakFXMTRPbWM3M3ZKdCtC?=
 =?utf-8?B?d3BWSGN0M1NOTE90Y0dwcnBWdTFQOFdoM05oUzZvWmJSaThKTnBGUkhuRkNO?=
 =?utf-8?B?SDNEdnZ2RU9zQXhiaS91TWpJOWFHWW9MZjRzc3JUQ2FmOVBrbFVpZEdpVnZC?=
 =?utf-8?B?cjZFTEd2c09mZHRiajVkMkpzb1hDbmc5djdRd3hIN00vejNUUnZhNjN6VDh2?=
 =?utf-8?B?MWtINi9EclRXelVOaGx5MzRkcllLN0o5cHBZMlJQQ2FRRkhaSEVHQmdDUXRD?=
 =?utf-8?B?bW14Zmt0NzVSTzh6WkNPejVRZkdSTlZ5VjFKeXN5bWdkU0RncU93WVF0d05v?=
 =?utf-8?B?U29qV2oxNGhqOU5NRWJwYldlcHJrL2ZMKzY3TkpoRFVpaWYrN3NMM0RlQXJW?=
 =?utf-8?B?MUQ5RWxCSFdUdHF0dWFFdjE1YkFOZ1pabnA2Q1FIQU5EZy9Qd1hDbkJEeUlo?=
 =?utf-8?B?YTlMbjRRd3VoeUxYRUQwcWM5dHdmZUQxTFE1WHlDRm5CS1RMZnNBYWNpUWFX?=
 =?utf-8?B?Q3ZhNmNwOWpqbC9QNEZFZHI1dmswNHhGbktndjVoMisxd08rOWl4bGJaaU5t?=
 =?utf-8?B?UnRzN2k1N3hPdHVjTit5SDRyMkU5c2pwZHo5S2N6Mm9lOWZleldsWTRkYmY3?=
 =?utf-8?Q?dGAvZBnOhdfa0eXZgdMJeJb3W?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0aefb92-035c-447d-52ad-08dbae0cf7b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 12:38:12.1582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8n/SGTRRg1AEEfZe2NS/D9pECNN6MpnrG02tY84UH8LTWLKruQspM34SvEdsn8MO6e64vQv8KEhcqpmoP//1Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7654
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEpvbmVzIDxh
am9uZXNAdmVudGFuYW1pY3JvLmNvbT4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDUsIDIw
MjMgNjozMiBQTQ0KPiBUbzogV2FuZywgWGlhbyBXIDx4aWFvLncud2FuZ0BpbnRlbC5jb20+DQo+
IENjOiBBbnVwIFBhdGVsIDxhcGF0ZWxAdmVudGFuYW1pY3JvLmNvbT47IENvbm9yIERvb2xleQ0K
PiA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+OyBBbnVwIFBhdGVsIDxhbnVwQGJyYWluZmF1
bHQub3JnPjsNCj4gcGF1bC53YWxtc2xleUBzaWZpdmUuY29tOyBwYWxtZXJAZGFiYmVsdC5jb207
IGFvdUBlZWNzLmJlcmtlbGV5LmVkdTsNCj4gYXJkYkBrZXJuZWwub3JnOyBMaSwgSGFpY2hlbmcg
PGhhaWNoZW5nLmxpQGludGVsLmNvbT47IGxpbnV4LQ0KPiByaXNjdkBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBsaW51eC1lZmlAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBSSVNDLVY6IE9wdGltaXplIGJpdG9wcyB3
aXRoIFpiYiBleHRlbnNpb24NCj4gDQo+IA0KPiBIaSBYaWFvLA0KPiANCj4gT24gVHVlLCBTZXAg
MDUsIDIwMjMgYXQgMDk6NDY6MjBBTSArMDAwMCwgV2FuZywgWGlhbyBXIHdyb3RlOg0KPiA+DQo+
ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBBbmRyZXcg
Sm9uZXMgPGFqb25lc0B2ZW50YW5hbWljcm8uY29tPg0KPiA+ID4gU2VudDogRnJpZGF5LCBTZXB0
ZW1iZXIgMSwgMjAyMyAxOjAwIEFNDQo+ID4gPiBUbzogQW51cCBQYXRlbCA8YXBhdGVsQHZlbnRh
bmFtaWNyby5jb20+DQo+ID4gPiBDYzogV2FuZywgWGlhbyBXIDx4aWFvLncud2FuZ0BpbnRlbC5j
b20+OyBDb25vciBEb29sZXkNCj4gPiA+IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT47IEFu
dXAgUGF0ZWwgPGFudXBAYnJhaW5mYXVsdC5vcmc+Ow0KPiA+ID4gcGF1bC53YWxtc2xleUBzaWZp
dmUuY29tOyBwYWxtZXJAZGFiYmVsdC5jb207IGFvdUBlZWNzLmJlcmtlbGV5LmVkdTsNCj4gPiA+
IGFyZGJAa2VybmVsLm9yZzsgTGksIEhhaWNoZW5nIDxoYWljaGVuZy5saUBpbnRlbC5jb20+OyBs
aW51eC0NCj4gPiA+IHJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWVmaUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiA+ID4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3Vi
amVjdDogUmU6IFtQQVRDSF0gUklTQy1WOiBPcHRpbWl6ZSBiaXRvcHMgd2l0aCBaYmIgZXh0ZW5z
aW9uDQo+ID4gPg0KPiA+ID4gT24gVGh1LCBBdWcgMzEsIDIwMjMgYXQgMDk6Mzc6MzBQTSArMDUz
MCwgQW51cCBQYXRlbCB3cm90ZToNCj4gPiA+ID4gK0FuZHJldw0KPiA+ID4gPg0KPiA+ID4gPiBP
biBUaHUsIEF1ZyAzMSwgMjAyMyBhdCA5OjI54oCvUE0gV2FuZywgWGlhbyBXDQo+IDx4aWFvLncu
d2FuZ0BpbnRlbC5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+ID4gRnJvbTogQ29u
b3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4gPiA+ID4gPiA+IFNlbnQ6
IFdlZG5lc2RheSwgQXVndXN0IDMwLCAyMDIzIDI6NTkgUE0NCj4gPiA+ID4gPiA+IFRvOiBXYW5n
LCBYaWFvIFcgPHhpYW8udy53YW5nQGludGVsLmNvbT4NCj4gPiA+ID4gPiA+IENjOiBBbnVwIFBh
dGVsIDxhbnVwQGJyYWluZmF1bHQub3JnPjsgcGF1bC53YWxtc2xleUBzaWZpdmUuY29tOw0KPiA+
ID4gPiA+ID4gcGFsbWVyQGRhYmJlbHQuY29tOyBhb3VAZWVjcy5iZXJrZWxleS5lZHU7IGFyZGJA
a2VybmVsLm9yZzsgTGksDQo+ID4gPiBIYWljaGVuZw0KPiA+ID4gPiA+ID4gPGhhaWNoZW5nLmxp
QGludGVsLmNvbT47IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiA+
ID4gPiA+ID4gZWZpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiA+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gUklTQy1WOiBPcHRpbWl6ZSBiaXRv
cHMgd2l0aCBaYmIgZXh0ZW5zaW9uDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gT24gV2VkLCBB
dWcgMzAsIDIwMjMgYXQgMDY6MTQ6MTJBTSArMDAwMCwgV2FuZywgWGlhbyBXIHdyb3RlOg0KPiA+
ID4gPiA+ID4gPiBIaSwNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+ID4gPiA+IEZyb206IEFudXAgUGF0ZWwgPGFudXBA
YnJhaW5mYXVsdC5vcmc+DQo+ID4gPiA+ID4gPiA+ID4gU2VudDogVHVlc2RheSwgQXVndXN0IDI5
LCAyMDIzIDc6MDggUE0NCj4gPiA+ID4gPiA+ID4gPiBUbzogV2FuZywgWGlhbyBXIDx4aWFvLncu
d2FuZ0BpbnRlbC5jb20+DQo+ID4gPiA+ID4gPiA+ID4gQ2M6IHBhdWwud2FsbXNsZXlAc2lmaXZl
LmNvbTsgcGFsbWVyQGRhYmJlbHQuY29tOw0KPiA+ID4gPiA+ID4gPiA+IGFvdUBlZWNzLmJlcmtl
bGV5LmVkdTsgYXJkYkBrZXJuZWwub3JnOyBMaSwgSGFpY2hlbmcNCj4gPiA+ID4gPiA+ID4gPiA8
aGFpY2hlbmcubGlAaW50ZWwuY29tPjsgbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
bGludXgtDQo+ID4gPiA+ID4gPiA+ID4gZWZpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFJJ
U0MtVjogT3B0aW1pemUgYml0b3BzIHdpdGggWmJiIGV4dGVuc2lvbg0KPiA+ID4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiA+ID4gT24gU3VuLCBBdWcgNiwgMjAyMyBhdCA4OjA54oCvQU0gWGlhbyBX
YW5nDQo+ID4gPiA8eGlhby53LndhbmdAaW50ZWwuY29tPg0KPiA+ID4gPiA+ID4gd3JvdGU6DQo+
ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gVGhpcyBwYXRjaCBsZXZlcmFnZXMg
dGhlIGFsdGVybmF0aXZlIG1lY2hhbmlzbSB0byBkeW5hbWljYWxseQ0KPiA+ID4gb3B0aW1pemUN
Cj4gPiA+ID4gPiA+ID4gPiA+IGJpdG9wcyAoaW5jbHVkaW5nIF9fZmZzLCBfX2ZscywgZmZzLCBm
bHMpIHdpdGggWmJiIGluc3RydWN0aW9ucy4gV2hlbg0KPiA+ID4gPiA+ID4gPiA+ID4gWmJiIGV4
dCBpcyBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBydW50aW1lIENQVSwgbGVnYWN5DQo+IGltcGxlbWVu
dGF0aW9uDQo+ID4gPiBpcw0KPiA+ID4gPiA+ID4gPiA+ID4gdXNlZC4gSWYgWmJiIGlzIHN1cHBv
cnRlZCwgdGhlbiB0aGUgb3B0aW1pemVkIHZhcmlhbnRzIHdpbGwgYmUNCj4gPiA+IHNlbGVjdGVk
DQo+ID4gPiA+ID4gPiA+ID4gPiB2aWEgYWx0ZXJuYXRpdmUgcGF0Y2hpbmcuDQo+ID4gPiA+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gVGhlIGxlZ2FjeSBiaXRvcHMgc3VwcG9ydCBpcyB0
YWtlbiBmcm9tIHRoZSBnZW5lcmljIEMNCj4gPiA+IGltcGxlbWVudGF0aW9uIGFzDQo+ID4gPiA+
ID4gPiA+ID4gPiBmYWxsYmFjay4NCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4g
PiBJZiB0aGUgcGFyYW1ldGVyIGlzIGEgYnVpbGQtdGltZSBjb25zdGFudCwgd2UgbGV2ZXJhZ2Ug
Y29tcGlsZXINCj4gPiA+IGJ1aWx0aW4gdG8NCj4gPiA+ID4gPiA+ID4gPiA+IGNhbGN1bGF0ZSB0
aGUgcmVzdWx0IGRpcmVjdGx5LCB0aGlzIGFwcHJvYWNoIGlzIGluc3BpcmVkIGJ5IHg4Ng0KPiBi
aXRvcHMNCj4gPiA+ID4gPiA+ID4gPiA+IGltcGxlbWVudGF0aW9uLg0KPiA+ID4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gPiA+IEVGSSBzdHViIHJ1bnMgYmVmb3JlIHRoZSBrZXJuZWwsIHNv
IGFsdGVybmF0aXZlIG1lY2hhbmlzbSBzaG91bGQNCj4gbm90DQo+ID4gPiBiZQ0KPiA+ID4gPiA+
ID4gPiA+ID4gdXNlZCB0aGVyZSwgdGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgbWFjcm8gRUZJX05P
X0FMVEVSTkFUSVZFDQo+IGZvcg0KPiA+ID4gdGhpcw0KPiA+ID4gPiA+ID4gPiA+ID4gcHVycG9z
ZS4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IEkgYW0gZ2V0dGluZyB0aGUgZm9s
bG93aW5nIGNvbXBpbGUgZXJyb3Igd2l0aCB0aGlzIHBhdGNoOg0KPiA+ID4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiA+ID4gICBHRU4gICAgIE1ha2VmaWxlDQo+ID4gPiA+ID4gPiA+ID4gICBVUEQg
ICAgIGluY2x1ZGUvY29uZmlnL2tlcm5lbC5yZWxlYXNlDQo+ID4gPiA+ID4gPiA+ID4gICBVUEQg
ICAgIGluY2x1ZGUvZ2VuZXJhdGVkL3V0c3JlbGVhc2UuaA0KPiA+ID4gPiA+ID4gPiA+ICAgQ0Mg
ICAgICBrZXJuZWwvYm91bmRzLnMNCj4gPiA+ID4gPiA+ID4gPiBJbiBmaWxlIGluY2x1ZGVkIGZy
b20gL2hvbWUvYW51cC9Xb3JrL3Jpc2N2LQ0KPiA+ID4gPiA+ID4gPiA+IHRlc3QvbGludXgvaW5j
bHVkZS9saW51eC9iaXRtYXAuaDo5LA0KPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAg
ZnJvbQ0KPiA+ID4gPiA+ID4gPiA+IC9ob21lL2FudXAvV29yay9yaXNjdi0NCj4gPiA+ID4gPiA+
IHRlc3QvbGludXgvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9jcHVmZWF0dXJlLmg6OSwNCj4gPiA+
ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgIGZyb20NCj4gPiA+ID4gPiA+ID4gPiAvaG9tZS9h
bnVwL1dvcmsvcmlzY3YtDQo+ID4gPiB0ZXN0L2xpbnV4L2FyY2gvcmlzY3YvaW5jbHVkZS9hc20v
aHdjYXAuaDo5MCwNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4g
SXQgbG9va3MgdGhlcmUncyBhIGN5Y2xpYyBoZWFkZXIgaW5jbHVkaW5nLCB3aGljaCBsZWFkcyB0
byB0aGlzIGJ1aWxkDQo+IGVycm9yLg0KPiA+ID4gPiA+ID4gPiBJIGNoZWNrZWQgaHR0cHM6Ly9n
aXRodWIuY29tL2t2bS1yaXNjdi9saW51eC90cmVlL21hc3RlciBhbmQNCj4gPiA+ID4gPiA+ID4g
aHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L3RyZWUvbWFzdGVyLCBidXQgSSBkb24n
dCBzZWUNCj4gPiA+ID4gPiA+ID4gImFzbS9jcHVmZWF0dXJlLmgiIGlzIGluY2x1ZGVkIGluIGFz
bS9od2NhcC5oOjkwLCBtYXliZSBJIG1pc3MNCj4gPiA+ID4gPiA+IHNvbWV0aGluZywNCj4gPiA+
ID4gPiA+ID4gY291bGQgeW91IGhlbHAgcG9pbnQgbWUgdG8gdGhlIHJlcG8vYnJhbmNoIEkgc2hv
dWxkIHdvcmsgb24/DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gRnJvbSBNQUlOVEFJTkVSUzoN
Cj4gPiA+ID4gPiA+ICAgICAgIFJJU0MtViBBUkNISVRFQ1RVUkUNCj4gPiA+ID4gPiA+ICAgICAg
IC4uLg0KPiA+ID4gPiA+ID4gICAgICAgVDogICAgICBnaXQgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Jpc2N2L2xpbnV4LmdpdA0KPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+IFRoZSBmb3ItbmV4dCBicmFuY2ggdGhlcmUgaXMgd2hhdCB5b3Ugc2hvdWxkIGJl
IGJhc2luZyB3b3JrIG9uIHRvcA0KPiBvZi4NCj4gPiA+ID4gPiA+IEFGQUlDVCwgeW91J3ZlIG1h
ZGUgYml0b3BzLmggaW5jbHVkZSBod2NhcC5oIHdoaWxlIGNwdWZlYXR1cmUuaA0KPiA+ID4gaW5j
bHVkZXMNCj4gPiA+ID4gPiA+IGJvdGggYml0b3BzLmggKGluZGlyZWN0bHkpIGFuZCBod2NhcC5o
Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhhbmtzIGZvciB0aGUgaW5mbywgYnV0IEkgY2FuJ3Qg
cmVwcm9kdWNlIEFudXAncyBidWlsZCBlcnJvciB3aXRoIHRoaXMNCj4gZm9yLQ0KPiA+ID4gbmV4
dCBicmFuY2gsIGNwdWZlYXR1cmUuaCBpcyBub3QgaW5jbHVkZWQgYnkgaHdjYXAuaCB0aGVyZS4N
Cj4gPiA+ID4gPiBNYXliZSBBbnVwIGNvdWxkIGhlbHAgZG91YmxlIGNoZWNrIHRoZSB0ZXN0IGVu
dmlyb25tZW50Pw0KPiA+ID4gPg0KPiA+ID4gPiBJIGZpZ3VyZWQgdGhhdCBjcHVmZWF0dXJlLmgg
aW5jbHVkZWQgaW4gaHdjYXAuaCBpcyBhZGRlZCBieQ0KPiA+ID4gPiBEcmV3J3MgcGF0Y2ggIlJJ
U0MtVjogRW5hYmxlIGNiby56ZXJvIGluIHVzZXJtb2RlIg0KPiA+ID4NCj4gPiA+IEkgdGhpbmsg
d2Ugc2hvdWxkIHByb2JhYmx5IHNwbGl0IGh3Y2FwLmggaW50byB0d28gcGFydHMuIFRoZSBkZWZp
bmVzIHN0YXkNCj4gPiA+IGFuZCB0aGUgcmVzdCBjYW4gbW92ZSB0byBjcHVmZWF0dXJlLmgNCj4g
Pg0KPiA+IE9LLCBJIHdpbGwgYmFzZSBvbiB5b3VyIGNiby56ZXJvIGVuYWJsaW5nIHBhdGNoIHNl
cmllcyB0byBtYWtlIGEgbmV3IHZlcnNpb24uDQo+IFdpbGwgbW92ZSBzb21lIGNvbnRlbnRzIGZy
b20gaHdjYXAuaCBpbnRvIGNwdWZlYXR1cmUuaCBzbyB0aGF0IHdlIGNhbg0KPiByZW1vdmUgdGhl
IGluY2x1ZGluZyBvZiBjcHVmZWF0dXJlLmggaW4gaHdjYXAuaC4NCj4gPg0KPiANCj4gSSBqdXN0
IHJlYWxpemVkIEkgZm9yZ290IHRvIENDIHlvdSBvbiBteSB2MyBwb3N0aW5nIG9mIHRoZSBjYm8u
emVybw0KPiBzZXJpZXNbMV0geWVzdGVyZGF5LiBTb3JyeSBhYm91dCB0aGF0Lg0KPiANCj4gWzFd
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDkwNDE3MDIyMC4xNjc4MTYtOC0NCj4g
YWpvbmVzQHZlbnRhbmFtaWNyby5jb20vDQo+IA0KPiBUaGFua3MsDQo+IGRyZXcNCg0KTlAsIEkg
d2lsbCB0YWtlIGEgbG9vayBhdCB0aGF0Lg0KDQpCUnMsDQpYaWFvDQo=
