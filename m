Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0094470B1
	for <lists+linux-efi@lfdr.de>; Sat,  6 Nov 2021 22:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhKFViE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 6 Nov 2021 17:38:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:6920 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229828AbhKFViD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 6 Nov 2021 17:38:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10160"; a="212120173"
X-IronPort-AV: E=Sophos;i="5.87,215,1631602800"; 
   d="scan'208";a="212120173"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2021 14:35:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,215,1631602800"; 
   d="scan'208";a="502444185"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga008.jf.intel.com with ESMTP; 06 Nov 2021 14:35:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sat, 6 Nov 2021 14:35:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sat, 6 Nov 2021 14:35:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sat, 6 Nov 2021 14:35:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWG4T8uxHR4XQN/5T7qOI63VXZ2l0sud1ELhcWgY+oTAsoq4BNg+L8p13mPgQEQzdPYhm1O25iZ438WfjiY0uVZ5m8DuHMhVvvq0wzakhiT27cHIEzm+tjMyFK1+TkpEnaiMORmnQQr5ctwa/p45x0moWSKXpk0uPmEB0SfzaB7oVL8iTGD/cZ+22TZAfnu5Zo9efP5p5xhKL9l0m/Wg+vx4H1wiUUJqB3czMAV4K1Qp/92rdbJidyzwNUbhKVxJ17INt8L+zbylqKXQ/u939gMGXP7C9mmJMOu4oA86YLWGi85IuM9FYOqO4Afjd953JLDTQrdRictGqYxeJlEqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEaTAh+gw40B/EFEQJRKFTV1Ma9LduaXGD6s/HsYT+E=;
 b=B1xhMnOImU7wpuUxa8wYwzUaeVgsVHJIlqMlpIO9g4cSCNZjRzJjs19Nji5xe16mxfjjec1+xMt8zrVsaWktgnSpydpI9/n3AV4JYqEDA4nB+8RprQwgjWDaU8VsLPdZ7rh4YvhcfUy73cidaCLURtfOvuWwmymgVUfBvBrAbshmJxNxhXR5r64mBXLKy6O8IAYsPbKnrVSKfMsvSIVLSWHsyXE4kl1Untp/AXRjVvaWy2Y2pL5sitwrrDckK1cWKQRK0Sci1Uh/4OPRYGqh0FSDQPlzSq/ItYy8uOmCEAAP/dtK57f2+pA1gTct3Fe2G1vvexg8dwq2K6u+TeELLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEaTAh+gw40B/EFEQJRKFTV1Ma9LduaXGD6s/HsYT+E=;
 b=UC8qQsntjwuj6T0Uh0YaRYH83WBfoehQ0lsV8UPFfuhYD5UJB41mLnMWSPOF7vwwiytaMqQtE9MW8T+uhM6wlJtSlbcheTjgHGwoYsGTg7O2kY1MTaBOjtPMgnJZpw1NjZAeuWZwmbQK1ru0+87f7KcuyOwk+PL053s5P8sIwUs=
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com (2603:10b6:a03:2d4::18)
 by BY5PR11MB4449.namprd11.prod.outlook.com (2603:10b6:a03:1cc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Sat, 6 Nov
 2021 21:35:16 +0000
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::1c99:cc97:391:1406]) by SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::1c99:cc97:391:1406%8]) with mapi id 15.20.4669.015; Sat, 6 Nov 2021
 21:35:16 +0000
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "martin.fernandez@eclypsium.com" <martin.fernandez@eclypsium.com>
CC:     "ardb@kernel.org" <ardb@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hughsient@gmail.com" <hughsient@gmail.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "alex@eclypsium.com" <alex@eclypsium.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.gutson@eclypsium.com" <daniel.gutson@eclypsium.com>,
        "andy@infradead.org" <andy@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 0/5] x86: Show in sysfs if a memory node is able to do
 encryption
Thread-Topic: [PATCH 0/5] x86: Show in sysfs if a memory node is able to do
 encryption
Thread-Index: AQHX01YwtP9Zhdw/AUG9EhZY9nCGVg==
Date:   Sat, 6 Nov 2021 21:35:16 +0000
Message-ID: <ec77822e45be2c9736ecb6e101c5321c10b560e7.camel@intel.com>
References: <20211105212724.2640-1-martin.fernandez@eclypsium.com>
In-Reply-To: <20211105212724.2640-1-martin.fernandez@eclypsium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-2.fc34) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47b2dcf2-1d89-4f36-0d9c-08d9a16d52e8
x-ms-traffictypediagnostic: BY5PR11MB4449:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BY5PR11MB4449CC1D0FA1FD3A0461BDD3C68F9@BY5PR11MB4449.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sMEvWFAgMgLZcgRJ5SXQFpo+qCU8wy5ZVOjpuDT1F1lizqmjjkPsUxjAXzdQCVer3n0NKA/3fF49BrgFhASzB6T8zmurC5SX9SyInPbq64UhvOD4U9s4fo0OF89mp6O2MLEIqlcko4BG49mNfw5G5a+yWGdhKaY380fkBOXIv5vxBV3lNwl+kGofyyKaBobeo6o4pftCg5VqzuatO2nA0JAWtEGohI/Wa71LgjheRAWNQyOBttfeaB60cqU4WPQVKw9QY2BG0MtRZYRMfgxRgEDjw55cw5LRdjYB1AVD2j4sbLmeYWvVOv0W1BSAIcPTe38uSmJJHj0IMtAdV+kAxBWbeStVeNxq6NsalCqANpSg71tJ5iWs+L5QuFEGGNrLF1Q4i5i9lVcnyo9nbAe4xoP8YYwbAo4W6PQsHIqZYVUHO7LMv40ROXeSTjsOMHgt4nHEwstOZZDUFc+WzEtqJNtx+tXk6x902ePdrB3ZcNBDEaRXssg07pvGTzlEluAbXmuoaHew/mGWmDotzBTYkwbjRBX75MhOjpykKr05aHn7tiUpE3WknO/S+CakmFeRg/O9/uKskHj1oxoR/2DhSggzSuNZNB53t0boMDsuT2QRvPvWo9R0aOLTU6ppmn2ELXtoZBCgYbPZHrwM2sMpNYBEKndGNFBLcFpxVvjQh4Teb66HPxarYdkL/l9JE9DPSBAL61bvnrBUYgBCpqC7f4N0uk0pg5gyoKRWQhn9uXOmZDOfdO+8fzMHQz8zb/6bemVu9TrL24YtYNi15WE5RetdoPVgibAl/vrVTJsAJcg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5150.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(38100700002)(122000001)(82960400001)(66946007)(316002)(26005)(91956017)(4326008)(86362001)(110136005)(5660300002)(66556008)(8936002)(66476007)(66446008)(7416002)(76116006)(2616005)(64756008)(54906003)(6486002)(2906002)(6512007)(71200400001)(966005)(6506007)(8676002)(186003)(36756003)(508600001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzVXNVNIUnFVWUx0Vm9uVzJmQVEzOTFIMTU4YW9zUUhxRWxtSE1TaUh2Vjlm?=
 =?utf-8?B?c2FWZHgvVVYza3FEd3BtZncrdkIwZmFubHVhcG1nQ2p3SnpTdUtHMWFxcytj?=
 =?utf-8?B?YVE1VFAzMExQVnBxWFd5RmcyeStmazlZNi9Hbk9tTXorM3NIZ09Jc1I4bE1i?=
 =?utf-8?B?cjFkcWNndmFDbTB0a0Y4TENvbTVvYU9oU3Q4OWJGSWhjQ3h6UU92VjRBcDMw?=
 =?utf-8?B?OStWbFJEcDhPV3VGZ0JIWjVkT1lUWlJSaTcvMHprSVI4bHdESHBGZTc0RmRE?=
 =?utf-8?B?eWh0YlZGWStVOHhHSzd4eEpFWU5zclQ3SDRlWHJEQTZVN3ZFN0RkUmtXb1FU?=
 =?utf-8?B?Wk1wUHhEYnJxU3dJRHA5V3YxMXNGVDVMUVRwNUc0SHFKYm5pNk5BN0dMWlZ2?=
 =?utf-8?B?amIwa3oyMlE3citCVWhIWENWc25uRFFUTGtqNnF1RW9xcFRlQzRPUVNZYzEv?=
 =?utf-8?B?cEFoTzJIdVlrTWIrbWlxd0JUYm1TNS8xTDVnMTkwcG5QK2EwY2laODJkTE56?=
 =?utf-8?B?b2Zrd1dUbGlhWWF3UlVSbkdLempWQlNGLzNxL0owamxhci85Vm9rU2JQeFh4?=
 =?utf-8?B?MW8wVG1SL2hsSldyM1VSY25UT1BXQnNUbU9iODdGY2tlMWlqVjIrU215VzNU?=
 =?utf-8?B?a0ZTTlNKQlFKQjZuSzdRNThTa2JQZmgvZ3lqMk1xWGhEQzNHTlZCbUtGYVZK?=
 =?utf-8?B?a3dHM3lPVWprNUQ4K210eWdxQzB0MjluS2c3OHQzV2l1NkRjbUQvckFlRTNj?=
 =?utf-8?B?N0NQM24zbFF3Z0tJanpOdk9rM2Fac0NFbllob1VBKzNOeWIvcmZtc2dsbXdr?=
 =?utf-8?B?RGdIdXlpMFVJaTBRRjROdjBRNTA2MjJad2RieU9USDQvZm5iN21qa2JBKy9n?=
 =?utf-8?B?LzBNR1dORHU5YW1uUVZrWmN1RlA0Tko2RUZKbXdmL282bytZTldmVnFpc08r?=
 =?utf-8?B?bFNQUTE3QkVJbFhreTZ6NDJ6WjhQeXN2OVJnZnpjbndYdkY3WHVNRTQ2L1dY?=
 =?utf-8?B?blUvT1diNmQyUCsrZDVOVXFuVUErdkF5NHA2S2J6SFYzd1lFWWZROFdvTWdn?=
 =?utf-8?B?SmtJUXFFY2VmOEJNcjFiZ1RaLytmNkNZaklCUStyUzFhWnZlQUY1aDZhQm4y?=
 =?utf-8?B?aW91bU1oMnBmOWZ5Z2xmZkM4Tmd4OVRIVENUZE81MGtSNjUrS05ncjFzYWFh?=
 =?utf-8?B?aTlCeWZ2b3J0SXhUZkFkamFjdTErTjU3bjVvaVZmK05oRnRRbDB1alhpb3NR?=
 =?utf-8?B?bWhyVDZrUjQreWVqc1J6UTROM2FsVVVDdlJTdjY4UWlWL3prVE1ucG5FdE9E?=
 =?utf-8?B?eDhwM1NRd1NjcEwraVhOUGJuRW5OS25yWEtUY3drNWVQOVA2c0ZWOVBCbVlu?=
 =?utf-8?B?MGl5dU9tQlpoemtBMTJtdlZHek1qT1ZLOXhxeS9JTE1TMTB2L0kzQURPOGlx?=
 =?utf-8?B?aGpTek1BbXN3Y0E1Ym9pTDB1QWhnSGhidkpJV3JpRmViZ2RrbHRHYVlnSita?=
 =?utf-8?B?TkxGR0tmOWt3RWpLcGtNbXdyTzROYlhwSHUra21EclJGNWJ0K05uOEpKNWRY?=
 =?utf-8?B?b2pVd2lna1ZuL05jSmlyYlBsc2tmUG5aV2hvYU5nMkc1N3VPWVM4dnZvb3Nk?=
 =?utf-8?B?YUJUNzNLYWV1bnZ3UUd2d2FFV0d0ZFY4QWJsU01LZ3VieG4yV2xHcC80cFI2?=
 =?utf-8?B?K2Y0OExoSmlmY2FxWmVUaS9UMnppeUxxNkJvQXVlak9MQVE3ZFNVWVM2YU1v?=
 =?utf-8?B?R2RXdEhBOXJwRU5YWW4wVWJPaDZhOTdaRUFMMThCNlNFbWk2aENneWdBd2RO?=
 =?utf-8?B?VThYMS9KZ0JnVlF2VW93RENYRkxlQU41NElYTlN5WFYzSGNIVllwMWhGQU45?=
 =?utf-8?B?TklMN1dkcDF6ZWR4OXFTWVVjMnhtVE5kK3ExL3FXb2gxVC9MUXB5V3BOZGV4?=
 =?utf-8?B?YlA3RStpUm8zYXJTeHhCSmc1MUc3R1NCVStnMitCQlphZDlHV1lGaFFLMmpR?=
 =?utf-8?B?YlYvc2xSNWVpSXBmb3dTOXo4YVBzNUttaHhXYTM4MVZMNVNPWm4zK2JjOTd1?=
 =?utf-8?B?VFFialVZd1hDeG1xVG50ald2VU9oSkc1bXdrNXJUME9Rc1A5Vk8xSEd1ejFD?=
 =?utf-8?B?endtOGRrRFhBOS82dDFOeXRrU2lUS2xOWVE3TU54dkhGRjFmNzROM3V2M0Jr?=
 =?utf-8?B?VEFDVXRjTGNGMkt3MlRadEp6MUZXMTREZUNmS1VKUVlwVDRla3dBUDIvT2dX?=
 =?utf-8?Q?mThJc4xcauVUVaJhX9ii1xsEhcNbR4u1TEO0awfCOw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A0FF5C09FD0DC4C89CE8791D053B525@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5150.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b2dcf2-1d89-4f36-0d9c-08d9a16d52e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2021 21:35:16.2419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZW23HgSiWxGjh0/73qKipbRx/ZqCHW0zrhNA8Kam8X8D9Hmp8wKylldLiH6WHR5Wc3lD9gO3SXsoXEjEvkxDPMbWoQ2gegXNt3XfUl15k8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4449
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gRnJpLCAyMDIxLTExLTA1IGF0IDE4OjI3IC0wMzAwLCBNYXJ0aW4gRmVybmFuZGV6IHdyb3Rl
Og0KPiBTaG93IGZvciBlYWNoIG5vZGUgaWYgZXZlcnkgbWVtb3J5IGRlc2NyaXB0b3IgaW4gdGhh
dCBub2RlIGhhcyB0aGUNCj4gRUZJX01FTU9SWV9DUFVfQ1JZUFRPIGF0dHJpYnV0ZS4NCg0KVGhl
IHByb2JsZW0gSSBoYXZlIHdpdGggRUZJX01FTU9SWV9DUFVfQ1JZUFRPIGlzIGl0IHRoYXQgaXMg
dmFndWUgd2hhdA0KbWVtb3J5IGVuY3J5cHRpb24gdGVjaG5vbG9neSBpcyBkZXBsb3llZCBhbmQg
ZG9lcyBub3QgdGVsbCB5b3UgYW55dGhpbmcNCmFib3V0IHdoZXRoZXIgaXQgaXMgaW4gZWZmZWN0
IG9yIG5vdC4NCg0KSWYgdGhpcyBpcyBqdXN0IGZvciBiYXNpYyBpbnZlbnRvcnkgZm9yIGRldGVy
bWluaW5nIGlmIG9uZSBwbGF0Zm9ybQ0KbWlnaHQgYmUgbW9yZSBzZWN1cmUgdGhhbiBhbm90aGVy
IHRoZW4gbWF5YmUgaXQgaXMgb2ssIGJ1dCBJIGRvbid0IGtub3cNCmhvdyB3ZWxsIHRoaXMgd2ls
bCBkb3ZldGFpbCB3aXRoIENYTCB0aGF0IGNhbiBkeW5hbWljYWxseSBkZWZpbmUgbWVtb3J5DQpy
YW5nZXMuIFRvIGRhdGUgSSd2ZSBvbmx5IHNlZW4gYSBzcGVjaWZpY2F0aW9uIGZvciBDWEwgTGlu
ayBlbmNyeXB0aW9uLA0KZGF0YSBhdCByZXN0IGVuY3J5cHRpb24gZm9yIENYTCBQTUVNLiBJIGlt
YWdpbmUgb25lIGRheSBpdCB3aWxsIGdhaW4NCmVuY3J5cHRpb24gY2FwYWJpbGl0aWVzLCBidXQg
dGhhdCB3b24ndCBiZSBzb21ldGhpbmcgdGhlIHBsYXRmb3JtDQpmaXJtd2FyZSB3aWxsIGFsd2F5
cyBiZSBpbnZvbHZlZCBlc3RhYmlzaGluZy4NCg0KPiANCj4gZnd1cGQgcHJvamVjdCBwbGFucyB0
byB1c2UgaXQgYXMgcGFydCBvZiBhIGNoZWNrIHRvIHNlZSBpZiB0aGUgdXNlcnMNCj4gaGF2ZSBw
cm9wZXJseSBjb25maWd1cmVkIG1lbW9yeSBoYXJkd2FyZSBlbmNyeXB0aW9uIGNhcGFiaWxpdGll
cy4gSXQncw0KPiBwbGFubmVkIHRvIG1ha2UgaXQgcGFydCBvZiBhIHNwZWNpZmljYXRpb24gdGhh
dCBjYW4gYmUgcGFzc2VkIHRvDQo+IHBlb3BsZSBwdXJjaGFzaW5nIGhhcmR3YXJlLiBJdCdzIGNh
bGxlZCBIb3N0IFNlY3VyaXR5IElEOg0KPiBodHRwczovL2Z3dXBkLmdpdGh1Yi5pby9saWJmd3Vw
ZHBsdWdpbi9oc2kuaHRtbA0KPiANCj4gVGhpcyBhbHNvIGNhbiBiZSB1c2VmdWwgaW4gdGhlIGZ1
dHVyZSBpZiBOVU1BIGRlY2lkZXMgdG8gcHJpb3JpdGl6ZQ0KPiBub2RlcyB0aGF0IGFyZSBhYmxl
IHRvIGRvIGVuY3J5cHRpb24uDQoNCkknZCBmZWVsIGJldHRlciBpZiB0aGlzIG9uZSBvbmUgc3Rl
cCBpbmRpcmVjdGVkIGZyb20gdGhlIHJhdyBFRkkNCmF0dHJpYnV0ZSBhbmQgbGV0IGFyY2hpdGVj
dHVyZXMgaW5kaWNhdGUgd2hldGhlciB0cmFmZmljIGdvaW5nIG92ZXIgdGhlDQptZW1vcnkgYnVz
IChERFIgLyBERFItVCAvIENYTCBldGMpIGlzIGtub3duIHRvIGJlIGVuY3J5cHRlZCBvciBub3Qu
DQpFRklfTUVNT1JZX0NQVV9DUllQVE8gZG9lcyBub3QgY29tbXVuaWNhdGUgdGhhdCBwcm9wZXJ0
eS4NCg0KPiANCj4gTWFydGluIEZlcm5hbmRleiAoNSk6DQo+IMKgIEV4dGVuZCBtZW1ibG9jayB0
byBzdXBwb3J0IG1lbW9yeSBlbmNyeXB0aW9uDQo+IMKgIEV4dGVuZCBwZ19kYXRhX3QgdG8gaG9s
ZCBpbmZvcm1hdGlvbiBhYm91dCBtZW1vcnkgZW5jcnlwdGlvbg0KPiDCoCBFeHRlbmQgZTgyMF90
YWJsZSB0byBob2xkIGluZm9ybWF0aW9uIGFib3V0IG1lbW9yeSBlbmNyeXB0aW9uDQo+IMKgIE1h
cmsgZTgyMF9lbnRyaWVzIGFzIGNyeXB0byBjYXBhYmxlIGZyb20gRUZJIG1lbW1hcA0KPiDCoCBT
aG93IGluIHN5c2ZzIGlmIGEgbWVtb3J5IG5vZGUgaXMgYWJsZSB0byBkbyBlbmNyeXB0aW9uDQo+
IA0KPiDCoERvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtZGV2aWNlcy1ub2RlIHzCoCAx
MCArKw0KPiDCoGFyY2gveDg2L2luY2x1ZGUvYXNtL2U4MjAvYXBpLmjCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqDCoCAyICsNCj4gwqBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9lODIwL3R5cGVz
LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKw0KPiDCoGFyY2gveDg2L2tlcm5lbC9l
ODIwLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMzIg
KysrKystDQo+IMKgYXJjaC94ODYvcGxhdGZvcm0vZWZpL2VmaS5jwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8IDEwOSArKysrKysrKysrKysrKysrKysrDQo+IMKgZHJpdmVycy9i
YXNlL25vZGUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCAxMCArKw0KPiDCoGluY2x1ZGUvbGludXgvbWVtYmxvY2suaMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNiArDQo+IMKgaW5jbHVkZS9saW51eC9t
bXpvbmUuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKg
IDIgKw0KPiDCoG1tL21lbWJsb2NrLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNzQgKysrKysrKysrKysrKw0KPiDCoG1t
L3BhZ2VfYWxsb2MuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+IMKgMTAgZmlsZXMgY2hhbmdlZCwgMjQ1IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50
YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtZGV2aWNlcy1ub2RlDQo+IA0KPiANCj4gYmFzZS1jb21t
aXQ6IDM5MDZmZTliYjdmMWEyYzg2NjdhZTU0ZTk2N2RjODY5MDgyNGY0ZWENCj4gLS0NCj4gMi4z
MC4yDQo+IA0KDQo=
