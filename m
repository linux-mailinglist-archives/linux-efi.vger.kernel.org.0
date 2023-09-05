Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C1D792A4E
	for <lists+linux-efi@lfdr.de>; Tue,  5 Sep 2023 18:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343651AbjIEQet (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 5 Sep 2023 12:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354129AbjIEJqe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 5 Sep 2023 05:46:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817091AD;
        Tue,  5 Sep 2023 02:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693907190; x=1725443190;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h0Vf7IxhPfdZnQYlMpe+pDcHo3TqBlcksvjIFJMmJ4E=;
  b=UGbAwJBXxoblhCKrHP7lPAOEG/w2Y/1RoEjhm50lXF7FVXySS98xR2p2
   9L16bUWXvSzHHLrjGMmI2AmtbXYsWOS2kdE3fq1jRZdO6WddsTmIPZgaS
   i/mKwKLEWl0ywW/1zkmSTe3FoCDsgdNdxcIqHvzDLljEh62dziZsK2Qq/
   0dbVIIMw1V4WYReJFKi+/xOiF2FRX50hoa2pVN+6/F/1kQ9xN8Ny/rAyD
   aQg3XJgro+BZQ41RPX35J3Q3K2sjmGr30mbkdZ1BQthBRVPoujgU2CdiY
   KG1T/v0loB/Ipe6He5xxwaPuH0j+8cuAK1EonFuCNL4NUuTNaJE9rFK7t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="376680796"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="376680796"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 02:46:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="987761904"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="987761904"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 02:46:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 02:46:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 02:46:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 02:46:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAMo8aNOAl0T1vkFCiKWSeEsHYFnItQPWvS5oQFkZENpaWPKNFdxiBE5ducayqBli4asxCHE5uMsXlAPo3Ur+dK6yGI0OZflEEQE967TRAOP7uA8ewE+l7wvlIoTgC0IEjS8DQHoGGkWY+PgYoRIWrUrPymBIK+GE4MMtq2IJQ2RUVDQ3ME9C6Q4XtsmSwWMFF70Sk30DkwH/mJUPfgusQmorhx9ifUjSBgj/gqFo8IgsPNqGtMIB06sPmmFTZBjfcmuMQ1kJ3iGK5Lim5QKdJoRZBgp8Tf+d+Lo6XW9gecj/SCneXjsN05ZhBNk+Ea6/DLflJK/Zx8WryMv7IRHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0Vf7IxhPfdZnQYlMpe+pDcHo3TqBlcksvjIFJMmJ4E=;
 b=Hzvi8b1l0MjiHpJ8WlMa/UxkxFx0ley9OjcbAkhXvJSds6KVSXRJfvapqUeszb87OmNyd7oV5xc8+tNEFHQYbJ+b0bGB36+HnDoqb3wMuJs/TbdHrP6EJC/nBPX4v2QKp8LJW3OCu3VBRy/PQHFZlQRmtU1W5Y4468p/VhkhGARx9kMKhesZFLY9T5mzqt2Vgz+bDqzTOGVWC6wWWC4ShFNhRnEyQaTiWvepcywj6qJE4EJc4eiEaGTZY2d4xDJSdpfQOJroqnq8ygBkcERwyNWJfmgBGKiPgivKVkusREKlqvdnqR+DHnd+7svbU6MpGOGgtiMGbwCvl+1lIq4iVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.27; Tue, 5 Sep 2023 09:46:20 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 09:46:20 +0000
From:   "Wang, Xiao W" <xiao.w.wang@intel.com>
To:     Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
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
Thread-Index: AQHZyA83tlYFgJbtxEiuzFgm3vAb3bABQgqAgAE4pICAABQygIACJNYwgAAGqACAAA6zgIAHX5Ew
Date:   Tue, 5 Sep 2023 09:46:20 +0000
Message-ID: <DM8PR11MB5751CDA12CB037C678F1B829B8E8A@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20230806024715.3061589-1-xiao.w.wang@intel.com>
 <CAAhSdy2_djw2JX+8tmF2V190+x9KLvt7u8rCX-TaGCKQrUVOYQ@mail.gmail.com>
 <DM8PR11MB57512001CAFA07EC58203A7BB8E6A@DM8PR11MB5751.namprd11.prod.outlook.com>
 <20230830-breeze-washboard-ef496d5c9d5a@wendy>
 <DM8PR11MB575116E5EE183D7D41361B74B8E5A@DM8PR11MB5751.namprd11.prod.outlook.com>
 <CAK9=C2XTS539ew_rty6_MOwyZkdBBbGBCzxp33u1UpMP5STAqQ@mail.gmail.com>
 <20230831-f0f847c5703875f1e67635c1@orel>
In-Reply-To: <20230831-f0f847c5703875f1e67635c1@orel>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|SJ0PR11MB7704:EE_
x-ms-office365-filtering-correlation-id: a41cb6a9-8da0-4225-4bb8-08dbadf4f592
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ze4T0F/GrnyNmU7Z1yiOkvXZyDhEdgGjJif/xvm8Hd9Uek2t85njh6HB4rE+jg8UvmK4X6QpvQt/1Rvk6ja7gXn3cDFbQQ+iIaDPmQMtF6q1at3Z7GoqePq5wtwUKF/rVhjVi97VR2CCtNVWzc0zgXT0qMU9xAo1u6xhHZc2GkBa/wE2xs0EPOIkvmYO8hN1Mf5pGpmFtfKk5WMQGy/qaYpLADWywql3U2M7LD3hZSGx5wH03gFUU/DcDZR0TBAQ9hBhWCWlolFfXb13vjZbLgd9Up2PFbPVb/vu6A0xxEZ26rHa8p8rqR+BPD4PvdoCCAZnms5ZkJZdUU38UqmplhpRV7Nug/q3mEXPkgX2Go3d71xJYyo706ISLA80ewQJzIujug3zzdC+Oe3F9DfNsOJ7398dbQg1GgkBk02uqzYmXpmQB9qwZsNasPkDVjqViO7ED/sear/ylwSpf0bbGzwv+teQO0cxLWVntYG9x3PKX5hLVDKmZ1j++ayGENfzOj/DemEIeab3B/Ok/KwboA8vPONQdACXrJc9J9Uenx13NHILR95GU3Qup1AK9VTDZE9vNWnJClFFYRFpVoyrm90pYM99oD+th3C8lb6O7o/VcdjPYseF/xhnYi2NAeYUd6P8evjaStvbqcptSoPq4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199024)(1800799009)(186009)(33656002)(8676002)(71200400001)(4326008)(8936002)(86362001)(6506007)(66556008)(66446008)(76116006)(66946007)(66476007)(64756008)(54906003)(966005)(110136005)(7696005)(9686003)(478600001)(53546011)(41300700001)(83380400001)(55016003)(316002)(38070700005)(38100700002)(5660300002)(52536014)(7416002)(122000001)(2906002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDBMdERXRHZWbTJsaVFIdXJXeVBsc3VkOHE1NWIvc2NpNzVCdXNEb3pka1JQ?=
 =?utf-8?B?RU9ZNzVQcnRDSi9CQllFRFVlUVFveUV2bGZ0dDhta0FkRGM0WWVkS1ZHZjJp?=
 =?utf-8?B?ZGd6QWM1OWJYM0RvT3hjOEs3am1vaDVGRkV2dlZSaTJBbW0vMDNiazRDVlpu?=
 =?utf-8?B?VTZLUklwK2VlTzhhVjJiYnByd3lEeExkVGs1cFBEV2I0bVlCRENtV1BZYUNm?=
 =?utf-8?B?TGpmdWtyZU5LaUFaN3hsQUZ4R1B4WldHTGRkRnpyK1JNVTVjbmZyZ2hCRG9q?=
 =?utf-8?B?VkdsNkNvdXZrTGVEVlJOQklsVWQ0Z3BMRENuZGZvNEEyTUQ4VWhhV0FhWkpa?=
 =?utf-8?B?TVpqWEt6a2dzUFZyaVdVWldCVWpseElGU0dwTXhrczIxbll5RFlwdWhNZS9P?=
 =?utf-8?B?eWs3S0sySnoxR0RicXhPaXpXc0xRZXFkUkRENlpZZVoyMlZMU2s3a2tXeUZT?=
 =?utf-8?B?aUtOL05jSFM2MjVxRGVDNFFoMjFLblMrKzVjZ2tpRGd6eG4zakNTVURPUXFQ?=
 =?utf-8?B?ZE81ZisrZDZWMFNxQ0FZb0h1a2tkejFlQ09TcU9JSUNZRnBLdmkxZU9QOUpx?=
 =?utf-8?B?L2lXSHprak45MW1QakN0TFlLcXlVSStYeEptZmh0dlJiWTIyME0zV1NOaWVH?=
 =?utf-8?B?WFlRNHJzcUtMTml0UFBpK0xDcjhaY0EvRnIrMytwZ3pNTFNacWd0MTdid3Ex?=
 =?utf-8?B?QzRONWthamdScERadmFKcUI3U0pTZStMU2FYRFAwa0l1Y1lSMS9RdmVhYjdY?=
 =?utf-8?B?SkJ5bDg4dkY5ZHZKUkdWdGhyMlhRdXhZYnNhUjZsQWNHaGZlaFBjdTlhUVcw?=
 =?utf-8?B?NjhsM3FDZVo5NXAxSmpGZGpqemhONmlUTjd1Zi90amVCOVo0RUo1ZVVlV0pQ?=
 =?utf-8?B?YXJLc1ZvMlBGSHRVMWUyMTJNU2lNazNQZHNwVDNlb0tUQ01HcHVzckxuNXUw?=
 =?utf-8?B?UXFwWEFvcDU0QmlIWnBhbGFCc3lOT1NlV2ZqY0xqUzF0NGRKQ2Rwa1VUdEhY?=
 =?utf-8?B?U3hCdG1PSjJ6a21XeURrUEI3UFdHa1loRXBYNWZWTW83MllzUnI2SkdMNkNj?=
 =?utf-8?B?dDdjRVhCSmV1R1gzL1czcTVyTjk5Znc5dWVYdkJHNUJ5WmlFYXVIQzBWL3BF?=
 =?utf-8?B?L0VFRnplbHJOdHJMdnZlOW4zamh1b3hrN0Z1OHdZSm1LUDlmU2NVcE9qL3dw?=
 =?utf-8?B?WUZULzZGV2c5V2wveVpzN3NRZ2FQN093TU5RcVZ3dDNyVmpTTXNRaFdic2R2?=
 =?utf-8?B?MExicHJINmxBa1JsQkpBR095cnlzWmZlT25aQzc2eWhUVElydzBHL0xCRmtH?=
 =?utf-8?B?TnBxTzVGckMrbU02YVZxd3ZKRmlObHRjY2FROG91azdhQzFMTTdFckV0SWZK?=
 =?utf-8?B?Q0NyS054QXFvT1c1UUJzUkljNCs2WFFMcmR0Z2FKc3FaMGcyRjNWTy94cXJ6?=
 =?utf-8?B?TUdQY05yd3BDVXBjOGJZQ2NoTE1RME1hZW45UCtNNkx6K1pjeVA4OWdkZHZU?=
 =?utf-8?B?dFdJdEtta1Y3UHl2SFdHemVVY3poTGdrdG91Z0MrSzhEazZGdS9aRkhoVC9X?=
 =?utf-8?B?Tk41a3pEZkdmZ1VGTXJPMmZEOXdnanA1WEdvWW5NWVVlN1c2ajB2UnBpckQv?=
 =?utf-8?B?QXdteFBQZG5xUjBhVkFxTVE2TWdvL1ducGRUOVdjZGwzcm9PYmJDMWZqazRK?=
 =?utf-8?B?ejhGT3BsUEpobmFWSXEvTzM5YnBjNzhhSDJSb0ZJRThwWWpHSHl5bWFJK0pI?=
 =?utf-8?B?RVZvSElIcmpBNTNtMVZkSlg2WkJOTlBKZSs0dnhad2xIeEIzd1ZEZDJLQkNl?=
 =?utf-8?B?dzVCU0x0aDkwSWRHNHJqVm9sS1oxTWx5Q3VDT2VlWjVxM0ZZQTVvV1dkaEpz?=
 =?utf-8?B?SEdtTk53TTVwZGQ1QlROY01DZ1NpcVE4YThmVWZ2U0RKZDV5RzFsR1dFU0pq?=
 =?utf-8?B?WFhQL0x0cXVhM2xQSWlLd3dHTFhBSzljR0FCa3J1QUMzZDBqY0NweGtqQU9r?=
 =?utf-8?B?SUQ4NmxsVzlqWjVSNDM2czIrSm9mOWlkSDBEcHRKZ0NJemhkUUNXdW1CeWVQ?=
 =?utf-8?B?bis3bm1lb21hVDZBbExFZ1pjWEVzMDhWOUE5V0pEWDc4ZElOQlhhQldWV3FU?=
 =?utf-8?Q?8TmI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41cb6a9-8da0-4225-4bb8-08dbadf4f592
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 09:46:20.6490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1WdtbKUPtrnx3rOun8FuAgBvz16QmO/tLjEW1OnPJjgq3ZLsnMkQeeaqtjYYnqTXLNgKmEiIIDFnxxXExP3ZWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7704
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
am9uZXNAdmVudGFuYW1pY3JvLmNvbT4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMSwgMjAy
MyAxOjAwIEFNDQo+IFRvOiBBbnVwIFBhdGVsIDxhcGF0ZWxAdmVudGFuYW1pY3JvLmNvbT4NCj4g
Q2M6IFdhbmcsIFhpYW8gVyA8eGlhby53LndhbmdAaW50ZWwuY29tPjsgQ29ub3IgRG9vbGV5DQo+
IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT47IEFudXAgUGF0ZWwgPGFudXBAYnJhaW5mYXVs
dC5vcmc+Ow0KPiBwYXVsLndhbG1zbGV5QHNpZml2ZS5jb207IHBhbG1lckBkYWJiZWx0LmNvbTsg
YW91QGVlY3MuYmVya2VsZXkuZWR1Ow0KPiBhcmRiQGtlcm5lbC5vcmc7IExpLCBIYWljaGVuZyA8
aGFpY2hlbmcubGlAaW50ZWwuY29tPjsgbGludXgtDQo+IHJpc2N2QGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWVmaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFJJU0MtVjogT3B0aW1pemUgYml0b3BzIHdp
dGggWmJiIGV4dGVuc2lvbg0KPiANCj4gT24gVGh1LCBBdWcgMzEsIDIwMjMgYXQgMDk6Mzc6MzBQ
TSArMDUzMCwgQW51cCBQYXRlbCB3cm90ZToNCj4gPiArQW5kcmV3DQo+ID4NCj4gPiBPbiBUaHUs
IEF1ZyAzMSwgMjAyMyBhdCA5OjI54oCvUE0gV2FuZywgWGlhbyBXIDx4aWFvLncud2FuZ0BpbnRl
bC5jb20+DQo+IHdyb3RlOg0KPiA+ID4NCj4gPiA+DQo+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4gPiA+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3Jv
Y2hpcC5jb20+DQo+ID4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDMwLCAyMDIzIDI6NTkg
UE0NCj4gPiA+ID4gVG86IFdhbmcsIFhpYW8gVyA8eGlhby53LndhbmdAaW50ZWwuY29tPg0KPiA+
ID4gPiBDYzogQW51cCBQYXRlbCA8YW51cEBicmFpbmZhdWx0Lm9yZz47IHBhdWwud2FsbXNsZXlA
c2lmaXZlLmNvbTsNCj4gPiA+ID4gcGFsbWVyQGRhYmJlbHQuY29tOyBhb3VAZWVjcy5iZXJrZWxl
eS5lZHU7IGFyZGJAa2VybmVsLm9yZzsgTGksDQo+IEhhaWNoZW5nDQo+ID4gPiA+IDxoYWljaGVu
Zy5saUBpbnRlbC5jb20+OyBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0N
Cj4gPiA+ID4gZWZpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBSSVNDLVY6IE9wdGltaXplIGJpdG9wcyB3
aXRoIFpiYiBleHRlbnNpb24NCj4gPiA+ID4NCj4gPiA+ID4gT24gV2VkLCBBdWcgMzAsIDIwMjMg
YXQgMDY6MTQ6MTJBTSArMDAwMCwgV2FuZywgWGlhbyBXIHdyb3RlOg0KPiA+ID4gPiA+IEhpLA0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4g
PiA+ID4gRnJvbTogQW51cCBQYXRlbCA8YW51cEBicmFpbmZhdWx0Lm9yZz4NCj4gPiA+ID4gPiA+
IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAyOSwgMjAyMyA3OjA4IFBNDQo+ID4gPiA+ID4gPiBUbzog
V2FuZywgWGlhbyBXIDx4aWFvLncud2FuZ0BpbnRlbC5jb20+DQo+ID4gPiA+ID4gPiBDYzogcGF1
bC53YWxtc2xleUBzaWZpdmUuY29tOyBwYWxtZXJAZGFiYmVsdC5jb207DQo+ID4gPiA+ID4gPiBh
b3VAZWVjcy5iZXJrZWxleS5lZHU7IGFyZGJAa2VybmVsLm9yZzsgTGksIEhhaWNoZW5nDQo+ID4g
PiA+ID4gPiA8aGFpY2hlbmcubGlAaW50ZWwuY29tPjsgbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgtDQo+ID4gPiA+ID4gPiBlZmlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBS
SVNDLVY6IE9wdGltaXplIGJpdG9wcyB3aXRoIFpiYiBleHRlbnNpb24NCj4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiBPbiBTdW4sIEF1ZyA2LCAyMDIzIGF0IDg6MDnigK9BTSBYaWFvIFdhbmcNCj4g
PHhpYW8udy53YW5nQGludGVsLmNvbT4NCj4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiA+IFRoaXMgcGF0Y2ggbGV2ZXJhZ2VzIHRoZSBhbHRlcm5hdGl2ZSBtZWNoYW5p
c20gdG8gZHluYW1pY2FsbHkNCj4gb3B0aW1pemUNCj4gPiA+ID4gPiA+ID4gYml0b3BzIChpbmNs
dWRpbmcgX19mZnMsIF9fZmxzLCBmZnMsIGZscykgd2l0aCBaYmIgaW5zdHJ1Y3Rpb25zLiBXaGVu
DQo+ID4gPiA+ID4gPiA+IFpiYiBleHQgaXMgbm90IHN1cHBvcnRlZCBieSB0aGUgcnVudGltZSBD
UFUsIGxlZ2FjeSBpbXBsZW1lbnRhdGlvbg0KPiBpcw0KPiA+ID4gPiA+ID4gPiB1c2VkLiBJZiBa
YmIgaXMgc3VwcG9ydGVkLCB0aGVuIHRoZSBvcHRpbWl6ZWQgdmFyaWFudHMgd2lsbCBiZQ0KPiBz
ZWxlY3RlZA0KPiA+ID4gPiA+ID4gPiB2aWEgYWx0ZXJuYXRpdmUgcGF0Y2hpbmcuDQo+ID4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiA+IFRoZSBsZWdhY3kgYml0b3BzIHN1cHBvcnQgaXMgdGFrZW4g
ZnJvbSB0aGUgZ2VuZXJpYyBDDQo+IGltcGxlbWVudGF0aW9uIGFzDQo+ID4gPiA+ID4gPiA+IGZh
bGxiYWNrLg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBJZiB0aGUgcGFyYW1ldGVyIGlz
IGEgYnVpbGQtdGltZSBjb25zdGFudCwgd2UgbGV2ZXJhZ2UgY29tcGlsZXINCj4gYnVpbHRpbiB0
bw0KPiA+ID4gPiA+ID4gPiBjYWxjdWxhdGUgdGhlIHJlc3VsdCBkaXJlY3RseSwgdGhpcyBhcHBy
b2FjaCBpcyBpbnNwaXJlZCBieSB4ODYgYml0b3BzDQo+ID4gPiA+ID4gPiA+IGltcGxlbWVudGF0
aW9uLg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBFRkkgc3R1YiBydW5zIGJlZm9yZSB0
aGUga2VybmVsLCBzbyBhbHRlcm5hdGl2ZSBtZWNoYW5pc20gc2hvdWxkIG5vdA0KPiBiZQ0KPiA+
ID4gPiA+ID4gPiB1c2VkIHRoZXJlLCB0aGlzIHBhdGNoIGludHJvZHVjZXMgYSBtYWNybyBFRklf
Tk9fQUxURVJOQVRJVkUgZm9yDQo+IHRoaXMNCj4gPiA+ID4gPiA+ID4gcHVycG9zZS4NCj4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiBJIGFtIGdldHRpbmcgdGhlIGZvbGxvd2luZyBjb21waWxlIGVy
cm9yIHdpdGggdGhpcyBwYXRjaDoNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAgIEdFTiAgICAg
TWFrZWZpbGUNCj4gPiA+ID4gPiA+ICAgVVBEICAgICBpbmNsdWRlL2NvbmZpZy9rZXJuZWwucmVs
ZWFzZQ0KPiA+ID4gPiA+ID4gICBVUEQgICAgIGluY2x1ZGUvZ2VuZXJhdGVkL3V0c3JlbGVhc2Uu
aA0KPiA+ID4gPiA+ID4gICBDQyAgICAgIGtlcm5lbC9ib3VuZHMucw0KPiA+ID4gPiA+ID4gSW4g
ZmlsZSBpbmNsdWRlZCBmcm9tIC9ob21lL2FudXAvV29yay9yaXNjdi0NCj4gPiA+ID4gPiA+IHRl
c3QvbGludXgvaW5jbHVkZS9saW51eC9iaXRtYXAuaDo5LA0KPiA+ID4gPiA+ID4gICAgICAgICAg
ICAgICAgICBmcm9tDQo+ID4gPiA+ID4gPiAvaG9tZS9hbnVwL1dvcmsvcmlzY3YtDQo+ID4gPiA+
IHRlc3QvbGludXgvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9jcHVmZWF0dXJlLmg6OSwNCj4gPiA+
ID4gPiA+ICAgICAgICAgICAgICAgICAgZnJvbQ0KPiA+ID4gPiA+ID4gL2hvbWUvYW51cC9Xb3Jr
L3Jpc2N2LQ0KPiB0ZXN0L2xpbnV4L2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vaHdjYXAuaDo5MCwN
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSXQgbG9va3MgdGhlcmUncyBhIGN5Y2xp
YyBoZWFkZXIgaW5jbHVkaW5nLCB3aGljaCBsZWFkcyB0byB0aGlzIGJ1aWxkIGVycm9yLg0KPiA+
ID4gPiA+IEkgY2hlY2tlZCBodHRwczovL2dpdGh1Yi5jb20va3ZtLXJpc2N2L2xpbnV4L3RyZWUv
bWFzdGVyIGFuZA0KPiA+ID4gPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC90
cmVlL21hc3RlciwgYnV0IEkgZG9uJ3Qgc2VlDQo+ID4gPiA+ID4gImFzbS9jcHVmZWF0dXJlLmgi
IGlzIGluY2x1ZGVkIGluIGFzbS9od2NhcC5oOjkwLCBtYXliZSBJIG1pc3MNCj4gPiA+ID4gc29t
ZXRoaW5nLA0KPiA+ID4gPiA+IGNvdWxkIHlvdSBoZWxwIHBvaW50IG1lIHRvIHRoZSByZXBvL2Jy
YW5jaCBJIHNob3VsZCB3b3JrIG9uPw0KPiA+ID4gPg0KPiA+ID4gPiBGcm9tIE1BSU5UQUlORVJT
Og0KPiA+ID4gPiAgICAgICBSSVNDLVYgQVJDSElURUNUVVJFDQo+ID4gPiA+ICAgICAgIC4uLg0K
PiA+ID4gPiAgICAgICBUOiAgICAgIGdpdCBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvcmlzY3YvbGludXguZ2l0DQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBmb3It
bmV4dCBicmFuY2ggdGhlcmUgaXMgd2hhdCB5b3Ugc2hvdWxkIGJlIGJhc2luZyB3b3JrIG9uIHRv
cCBvZi4NCj4gPiA+ID4gQUZBSUNULCB5b3UndmUgbWFkZSBiaXRvcHMuaCBpbmNsdWRlIGh3Y2Fw
Lmggd2hpbGUgY3B1ZmVhdHVyZS5oDQo+IGluY2x1ZGVzDQo+ID4gPiA+IGJvdGggYml0b3BzLmgg
KGluZGlyZWN0bHkpIGFuZCBod2NhcC5oLg0KPiA+ID4NCj4gPiA+IFRoYW5rcyBmb3IgdGhlIGlu
Zm8sIGJ1dCBJIGNhbid0IHJlcHJvZHVjZSBBbnVwJ3MgYnVpbGQgZXJyb3Igd2l0aCB0aGlzIGZv
ci0NCj4gbmV4dCBicmFuY2gsIGNwdWZlYXR1cmUuaCBpcyBub3QgaW5jbHVkZWQgYnkgaHdjYXAu
aCB0aGVyZS4NCj4gPiA+IE1heWJlIEFudXAgY291bGQgaGVscCBkb3VibGUgY2hlY2sgdGhlIHRl
c3QgZW52aXJvbm1lbnQ/DQo+ID4NCj4gPiBJIGZpZ3VyZWQgdGhhdCBjcHVmZWF0dXJlLmggaW5j
bHVkZWQgaW4gaHdjYXAuaCBpcyBhZGRlZCBieQ0KPiA+IERyZXcncyBwYXRjaCAiUklTQy1WOiBF
bmFibGUgY2JvLnplcm8gaW4gdXNlcm1vZGUiDQo+IA0KPiBJIHRoaW5rIHdlIHNob3VsZCBwcm9i
YWJseSBzcGxpdCBod2NhcC5oIGludG8gdHdvIHBhcnRzLiBUaGUgZGVmaW5lcyBzdGF5DQo+IGFu
ZCB0aGUgcmVzdCBjYW4gbW92ZSB0byBjcHVmZWF0dXJlLmgNCg0KT0ssIEkgd2lsbCBiYXNlIG9u
IHlvdXIgY2JvLnplcm8gZW5hYmxpbmcgcGF0Y2ggc2VyaWVzIHRvIG1ha2UgYSBuZXcgdmVyc2lv
bi4gV2lsbCBtb3ZlIHNvbWUgY29udGVudHMgZnJvbSBod2NhcC5oIGludG8gY3B1ZmVhdHVyZS5o
IHNvIHRoYXQgd2UgY2FuIHJlbW92ZSB0aGUgaW5jbHVkaW5nIG9mIGNwdWZlYXR1cmUuaCBpbiBo
d2NhcC5oLg0KDQpUaGFua3MsDQpYaWFvDQoNCj4gDQo+IFRoYW5rcywNCj4gZHJldw0KPiANCj4g
Pg0KPiA+IEkgaGFkIHRyaWVkIHRoaXMgcGF0Y2ggb24tdG9wLW9mIGRldi11cHN0cmVhbSBicmFu
Y2ggb2YNCj4gPiBodHRwczovL2dpdGh1Yi5jb20vdmVudGFuYW1pY3JvL2xpbnV4LmdpdA0KPiA+
DQo+ID4gUmVnYXJkcywNCj4gPiBBbnVwDQo+ID4NCj4gPiA+DQo+ID4gPiBCUnMsDQo+ID4gPiBY
aWFvDQo+ID4gPg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gSG9wZSB0aGF0IGhlbHBzLA0KPiA+
ID4gPiBDb25vci4NCj4gPiA+ID4NCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgZnJvbQ0K
PiA+ID4gPiA+ID4gL2hvbWUvYW51cC9Xb3JrL3Jpc2N2LQ0KPiB0ZXN0L2xpbnV4L2FyY2gvcmlz
Y3YvaW5jbHVkZS9hc20vYml0b3BzLmg6MjYsDQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAg
IGZyb20NCj4gPiA+ID4gPiA+IC9ob21lL2FudXAvV29yay9yaXNjdi10ZXN0L2xpbnV4L2luY2x1
ZGUvbGludXgvYml0b3BzLmg6NjgsDQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgIGZyb20g
L2hvbWUvYW51cC9Xb3JrL3Jpc2N2LQ0KPiB0ZXN0L2xpbnV4L2luY2x1ZGUvbGludXgvbG9nMi5o
OjEyLA0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICBmcm9tIC9ob21lL2FudXAvV29yay9y
aXNjdi0NCj4gdGVzdC9saW51eC9rZXJuZWwvYm91bmRzLmM6MTM6DQo+ID4gPiA+ID4gPiAvaG9t
ZS9hbnVwL1dvcmsvcmlzY3YtdGVzdC9saW51eC9pbmNsdWRlL2xpbnV4L2ZpbmQuaDogSW4gZnVu
Y3Rpb24NCj4gPiA+ID4gPiA+ICdmaW5kX25leHRfYml0JzoNCj4gPiA+ID4gPiA+IC9ob21lL2Fu
dXAvV29yay9yaXNjdi10ZXN0L2xpbnV4L2luY2x1ZGUvbGludXgvZmluZC5oOjY0OjMwOiBlcnJv
cjoNCj4gPiA+ID4gPiA+IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdfX2ZmcycN
Cj4gPiA+ID4gPiA+IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQ0KPiA+
ID4gPiA+ID4gICAgNjQgfCAgICAgICAgICAgICAgICAgcmV0dXJuIHZhbCA/IF9fZmZzKHZhbCkg
OiBzaXplOw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFJlZ2FyZHMsDQo+ID4gPiA+ID4gPiBB
bnVwDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogWGlhbyBXYW5nIDx4aWFvLncud2FuZ0BpbnRlbC5jb20+DQo+ID4g
PiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gPiAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9iaXRv
cHMuaCAgICAgICB8IDI2Ng0KPiA+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+
ID4gPiA+ID4gPiAgZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9NYWtlZmlsZSB8ICAgMiAr
LQ0KPiA+ID4gPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNjQgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2Fy
Y2gvcmlzY3YvaW5jbHVkZS9hc20vYml0b3BzLmgNCj4gPiA+ID4gPiA+IGIvYXJjaC9yaXNjdi9p
bmNsdWRlL2FzbS9iaXRvcHMuaA0KPiA+ID4gPiA+ID4gPiBpbmRleCAzNTQwYjY5MDk0NGIuLmY3
MjdmNjQ4OWNkNSAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gLS0tIGEvYXJjaC9yaXNjdi9pbmNsdWRl
L2FzbS9iaXRvcHMuaA0KPiA+ID4gPiA+ID4gPiArKysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNt
L2JpdG9wcy5oDQo+ID4gPiA+ID4gPiA+IEBAIC0xNSwxMyArMTUsMjczIEBADQo+ID4gPiA+ID4g
PiA+ICAjaW5jbHVkZSA8YXNtL2JhcnJpZXIuaD4NCj4gPiA+ID4gPiA+ID4gICNpbmNsdWRlIDxh
c20vYml0c3BlcmxvbmcuaD4NCg==
