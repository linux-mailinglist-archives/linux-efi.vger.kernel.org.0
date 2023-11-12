Return-Path: <linux-efi+bounces-45-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9517E8EE4
	for <lists+linux-efi@lfdr.de>; Sun, 12 Nov 2023 08:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797F51C204AB
	for <lists+linux-efi@lfdr.de>; Sun, 12 Nov 2023 07:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DFD2581;
	Sun, 12 Nov 2023 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Asrvb9aa"
X-Original-To: linux-efi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C7123DD
	for <linux-efi@vger.kernel.org>; Sun, 12 Nov 2023 07:05:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1162D64;
	Sat, 11 Nov 2023 23:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699772718; x=1731308718;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Is9smRHHOWOOoY4VmwP5jYzvYXI6zY72QWSlV8m61FI=;
  b=Asrvb9aaig7MDEdhdw6lRHJylGoPfU7L1MqJKFt+DtHzTffYxWwNMK6y
   LWU+NrDYGEaSkOj1eeMntsZMI+fpDRNOlxqBkMgezigs3prIcuG4mp9fb
   pjKwAxcMeHcAoyb1E9v9Ti01iETwtUJqQKeRi2fdg/tG7Qh8pHZDYF1ZY
   k2X2LRoQR5iQbAozWB1q8z20FiMUGQWMJJhO37CWZNGFkEcpK9+u35UFa
   GSKYNTtFB7V94JsjOhgTpl3qMTrRRn6eYVyJVVzacs2ZRPcUXCq6mkOth
   coetXtlJdxU/JTLeUuUiS+a+BfENrlTGXxFixSX77Uxchl+Rp1tuRI0Ju
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="375342885"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="375342885"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 23:05:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="757526338"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="757526338"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Nov 2023 23:05:16 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 23:05:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 23:05:15 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sat, 11 Nov 2023 23:05:15 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sat, 11 Nov 2023 23:05:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwR7hTT4mMZNcd5t23Hy5lTMRIDaT7zfjhvhfVUaby/oJGwwYleyIWLeAT759dPn8XOySjqcfCnjqwuixlOgsYxSJY/fMpccfihcE1s/EbH48NVP23k3Z5eQsiiM/1a23kv3vorOc7j6R/Z/DwPnHUofpT92tS7jhRnJgt024YtWqIji9w3AFIM72dw+eT+RSJiaiflJW+8I+NsuPA0vd6NFm1vc1P5/VaDOj5XIEiVvvcPu8SbJb5CGSPlPIZkI8HJ2Xm++DbX/ok1FNUjY1ojJWCP2wA1Kt9AsZxWJepDplNFqMwMgleEBZxTA984e4LWC1FtBbsSENbE723Fg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Is9smRHHOWOOoY4VmwP5jYzvYXI6zY72QWSlV8m61FI=;
 b=R1/f8IhZMx3BHY0/8AHtx7caJ111gyBLQJv+9FGmgmQiQOVcuf01mfbQYnS1y3SR0naXVPhLuBgfCcntlDGPtMwT/y4Swgsuq+ShUZ5m+8BrqVKIGjm7cx+OyTVaM5oQNKY9/Qb6PgW+D9W9R5vilJobOm5hgsX0c3pCZ1V/3jcJPqvJ/jGsLnKXNLIn6WhNtylfHRKJe7RzoL00oFGmV7PYogqybWPqQROGbwXVsir2ZU1JzW6TJBby1jvdY5FZYzFTYcDNGqmZgIPAZqAT8AI9qDKsjlly0mYTK/s3buGJRXQBE+rPBsXicCuxGlaUbq4kXJnsoHFWJo4ycxnLcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 IA0PR11MB7954.namprd11.prod.outlook.com (2603:10b6:208:40e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.26; Sun, 12 Nov
 2023 07:05:12 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::d070:1879:5b04:5f57]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::d070:1879:5b04:5f57%4]) with mapi id 15.20.6977.028; Sun, 12 Nov 2023
 07:05:12 +0000
From: "Wang, Xiao W" <xiao.w.wang@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "ardb@kernel.org" <ardb@kernel.org>,
	"anup@brainfault.org" <anup@brainfault.org>, "Li, Haicheng"
	<haicheng.li@intel.com>, "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
	"Liu, Yujie" <yujie.liu@intel.com>, "charlie@rivosinc.com"
	<charlie@rivosinc.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 2/2] riscv: Optimize bitops with Zbb extension
Thread-Topic: [PATCH v5 2/2] riscv: Optimize bitops with Zbb extension
Thread-Index: AQHaC8SSorVEQOH4iUSigU2sQRtDb7BzV/QAgAL2+cA=
Date: Sun, 12 Nov 2023 07:05:11 +0000
Message-ID: <DM8PR11MB575167A40A568B75E58E940AB8ACA@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20231031064553.2319688-1-xiao.w.wang@intel.com>
 <20231031064553.2319688-3-xiao.w.wang@intel.com>
 <CAMuHMdUQGtenM=_sNntW4mQ0K-7G=5_OhxG-AgQffMbR276W1w@mail.gmail.com>
In-Reply-To: <CAMuHMdUQGtenM=_sNntW4mQ0K-7G=5_OhxG-AgQffMbR276W1w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|IA0PR11MB7954:EE_
x-ms-office365-filtering-correlation-id: a23be1e5-7e31-479d-9453-08dbe34db6b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PKPgkTT0F+ny3i5PkXy5/yYuHcD8MoC52o0k6Vy8WzCS+NFE5StHYRqe8fQ+I6Wy3ROUIQLmjEvp48EiACSJj2pQm6hF4hLi0dyEQOfmAvD3ZjAyckbTVfsZWtYawue0sE1Xv9XbL7siWbQIOPzNMpYOctioZWTbF3cyfWfyoIQg/ZT+8ntUPydOX5pePLSCWh0w7yYAy7YbaSCXzLFa5PM5gZxVfFiH3GUBBSct6WrKhPYy4lJyMD/NEV/Fi6Nlp+m/f9aVsujZU9tHNj+X19xci3lR9XfjmwFsOp7gL899KCR9hRvsQRx6TIdJzD6xzS5BK3w40W8Lw0Bzl6nu/dWh66vFACnUfqHbtf+dVjs3ruc1Bu4Mxss8LZyY0mEdUwJHovT2mUvZs+wLUt1cKXDuCiVCZfgWmOX3H/ZmnwWMtlQXFstVz7OSqgTolnN0VKmHCLS1EgS08ZI1vSymDj1zEPBLqLR9L7skLSoR95bp38yEFcsAcYmLtffULNxGlGZNK+5NgnJU8ssFYLfMzYaCns7S+TgL7Vm2Ti3TYR4to0Q4jRysVavHuN9iSnzL0n23pPeJ9XjBQUk9ccbFP5AZS3Y3mSU2NpBjRYql+FjrDEC23K9veo1iAseiCaHN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(7416002)(38070700009)(2906002)(52536014)(71200400001)(5660300002)(86362001)(41300700001)(33656002)(26005)(82960400001)(54906003)(64756008)(66446008)(66556008)(66946007)(76116006)(66476007)(6916009)(9686003)(316002)(55016003)(83380400001)(38100700002)(478600001)(122000001)(7696005)(53546011)(6506007)(8676002)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekhwMC9LYjFCc0FKLzJKZ0hINTFCMitEeXlFWXpqaGdSUHBjNUtRQWhPTldo?=
 =?utf-8?B?NVRrc3htRnNhMkJJNXV3R2V1NWladUYrMk5OOURjbHBRS29JQ3k0ejd5SFdB?=
 =?utf-8?B?SnRQUy9NTTMyOWI2dlN4SEZWM05wei90Qy94SEIxWU9kWUw1SUw1aWVMYmFE?=
 =?utf-8?B?MnJ1UzNyc05EVjhoZzdEdTNXMWtUU0gyUkh5eUhLRDJtckcwUkpBK0hORlJh?=
 =?utf-8?B?THJiRHNmNTF3WW1PNExuSWQ1MDdtTHB2eGUzbW1hVUF1amZsbVFPWGhYTm5n?=
 =?utf-8?B?a01iZUJVekliSzhvdG04RFVrb0ZvaEtwNUpOcG1uSHVCcmlhN05QTlEzMjE5?=
 =?utf-8?B?OG41eVJvSTQxV3pRVktUcVpsN3NlOTBqUmlRMXB3WXNDZzVxV0IrZnJ3ZU14?=
 =?utf-8?B?Wm1GY1NSSjFmbk1EVGt1Yi9OVnBreVZRZy8xLzMzTit2UWNMS2lPTkVZTFJj?=
 =?utf-8?B?dmlTL3p3MERmaEo0MjRpSGZoSVN5ZjhiRU5Zc3ZMMjVIdXR4YXE0NUhqRGsy?=
 =?utf-8?B?TGt5MWVjR1MvWVZtSktvUjJDc3dDbE9id0hFTUpKVTRpYjQwRno4cnFLb3Y4?=
 =?utf-8?B?WkI0V0dTWjcrVXhwUmJ2aXBaZHBwS2kyZFVVSmJiMEZtaGlBR2JpR3NhdkxZ?=
 =?utf-8?B?K3NZaFZGVSsxeFBvbG52bmVYVGxINEZacEkxbGxkMXZTSHlCS043T3JMRFRm?=
 =?utf-8?B?R2R3cWNKdjNtMHg3UTJYcVoxRDVTMi8rR3g1T25UcVBaeUdQUTRzNFVMMytm?=
 =?utf-8?B?VkxFbmZhUEFKVUdhQko4cHBrNHUwa0NpZkVBWE5pNGxVMU9yYW1kYjlBTG4w?=
 =?utf-8?B?MVc2dExWdlVidDV0RXZpTitOUDJEZ2hPWmtsN1JMUHl6U3VWeE9FamcweUdG?=
 =?utf-8?B?VXcxTWt3TWVld1E3ZGhGZTFRMk5SSlovbjRDYlNPMFF0YXUwYjJPNUlqTEwv?=
 =?utf-8?B?QTJnVFBFcU1HeTZVZ0M3ZVBGM05KdEk0Lzh6UUNoZzgyR2dPaHVCdjBOR1NW?=
 =?utf-8?B?K3IvcWZXckFoVGFsTktoaEpPczZjUEhVWFprZ25CQlFrSmp0OHNadmhpajBV?=
 =?utf-8?B?WUNqK2p1Q1FHVnpCYTY2eEZXcXE5STArWXNqTkI4VjFiY0lXeFhnalNIQzJs?=
 =?utf-8?B?V1JHTGFHVCtZQ2xpS1J6aW04TEt1aGYzZ0ZacFVzQjhNbXRwbTd0Z0s5N1Ur?=
 =?utf-8?B?N3dXSHNjaVpCMzJOeHpUOWRmUE94Zkc1SEdwdnowWXhKd3VjcGZ5bWtDOGNn?=
 =?utf-8?B?dnMwc2cvZzdpU1o2N0p4citRL0Frb2s2c2NLT3lXYUZ5UEJ2eGVSM1dZVTZ1?=
 =?utf-8?B?MSt3QXFna0tOOCtUNVFIS2MzVzFSOUN3NUgxSGROdHB0R0VkMHpyVzlpOFMv?=
 =?utf-8?B?S2ZjOTMvWUV3UHBNZXhnOUlScE9icDNNeXBLcm04M0ppS2lxaFlhWmV2eEdV?=
 =?utf-8?B?dVJ3WWZsQkFHQmo1WWU3UGsyVndjTmRJZFN4ZlVWT1YxSU5TQU5VMEN5MDY5?=
 =?utf-8?B?UHhob1dQS1Y3L3lyK1BXNkFXdjBOUlJLSVNsdm5ERkE3cXhJZDl0LysyZlBZ?=
 =?utf-8?B?MkRveDB0UzdJZmh2TGw2bXdkdHpUdjlubHYwNnkrUHZ4eHNvUk1TcWpZMkk3?=
 =?utf-8?B?UnJrRExxenM2SjRlZXZUVmhnZm5lNm5ZeW8rVEhRTUswMmNNNFBKbUg5MTV4?=
 =?utf-8?B?c2piSFMvZ3h4dlJwTmlEdXFTSGN4aTZFS1VSQlY5RWYrNkd3cWFHYVk2Mmx2?=
 =?utf-8?B?UmI0Wk5ENUpuMDdDaGxaOVR6cllqYVR4akRWN1YxS1RrY054MWUxVWdWSWFp?=
 =?utf-8?B?V2tKazJ0aHJBVFRkVHRCbVdta1pjVEd1VENrY1BmclVxTllOcFNsaXoxaVZ3?=
 =?utf-8?B?dXNjMUdEL3ZSQ3FpbGFpQnJvNCtycU1LZTJuZWgvWlJHaVhkRHlRUzVXWjNv?=
 =?utf-8?B?OUFQK1B4d0dxN3BkaW5obTNLU1JXV2hza3lzOFdGaDB4ZlBjY2c2ekY5Q0J2?=
 =?utf-8?B?aWNzZnhnUGRNNU1kblFqM2xMbUNVOTlnUE9CZVllWmVNMEs0eFVmK0IvZnp4?=
 =?utf-8?B?RHBENlJMMFlSeUJhVkhQdDVCZmlzdklrOUkzOVM4aVl5SEU1anI0aEh0Lzl6?=
 =?utf-8?Q?60G+JlwQ378Un/oxpoCfN83HC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23be1e5-7e31-479d-9453-08dbe34db6b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2023 07:05:12.0259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AohDJQpIr/DqM1NlOFFJ+XrBzrH9xF9akToHL7HVbyuGROjz9kl5vK7oODRPNrNA8jGQkCOgTu+M72rOV7XnCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7954
X-OriginatorOrg: intel.com

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogRnJpZGF5LCBOb3Zl
bWJlciAxMCwgMjAyMyA1OjI1IFBNDQo+IFRvOiBXYW5nLCBYaWFvIFcgPHhpYW8udy53YW5nQGlu
dGVsLmNvbT4NCj4gQ2M6IHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbTsgcGFsbWVyQGRhYmJlbHQu
Y29tOw0KPiBhb3VAZWVjcy5iZXJrZWxleS5lZHU7IGFyZGJAa2VybmVsLm9yZzsgYW51cEBicmFp
bmZhdWx0Lm9yZzsgTGksIEhhaWNoZW5nDQo+IDxoYWljaGVuZy5saUBpbnRlbC5jb20+OyBham9u
ZXNAdmVudGFuYW1pY3JvLmNvbTsgTGl1LCBZdWppZQ0KPiA8eXVqaWUubGl1QGludGVsLmNvbT47
IGNoYXJsaWVAcml2b3NpbmMuY29tOyBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnOw0K
PiBsaW51eC1lZmlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMi8yXSByaXNjdjogT3B0aW1pemUgYml0b3BzIHdp
dGggWmJiIGV4dGVuc2lvbg0KPiANCj4gSGkgWGlhbywNCj4gDQo+IE9uIFR1ZSwgT2N0IDMxLCAy
MDIzIGF0IDc6MzfigK9BTSBYaWFvIFdhbmcgPHhpYW8udy53YW5nQGludGVsLmNvbT4gd3JvdGU6
DQo+ID4gVGhpcyBwYXRjaCBsZXZlcmFnZXMgdGhlIGFsdGVybmF0aXZlIG1lY2hhbmlzbSB0byBk
eW5hbWljYWxseSBvcHRpbWl6ZQ0KPiA+IGJpdG9wcyAoaW5jbHVkaW5nIF9fZmZzLCBfX2Zscywg
ZmZzLCBmbHMpIHdpdGggWmJiIGluc3RydWN0aW9ucy4gV2hlbg0KPiA+IFpiYiBleHQgaXMgbm90
IHN1cHBvcnRlZCBieSB0aGUgcnVudGltZSBDUFUsIGxlZ2FjeSBpbXBsZW1lbnRhdGlvbiBpcw0K
PiA+IHVzZWQuIElmIFpiYiBpcyBzdXBwb3J0ZWQsIHRoZW4gdGhlIG9wdGltaXplZCB2YXJpYW50
cyB3aWxsIGJlIHNlbGVjdGVkDQo+ID4gdmlhIGFsdGVybmF0aXZlIHBhdGNoaW5nLg0KPiA+DQo+
ID4gVGhlIGxlZ2FjeSBiaXRvcHMgc3VwcG9ydCBpcyB0YWtlbiBmcm9tIHRoZSBnZW5lcmljIEMg
aW1wbGVtZW50YXRpb24gYXMNCj4gPiBmYWxsYmFjay4NCj4gPg0KPiA+IElmIHRoZSBwYXJhbWV0
ZXIgaXMgYSBidWlsZC10aW1lIGNvbnN0YW50LCB3ZSBsZXZlcmFnZSBjb21waWxlciBidWlsdGlu
IHRvDQo+ID4gY2FsY3VsYXRlIHRoZSByZXN1bHQgZGlyZWN0bHksIHRoaXMgYXBwcm9hY2ggaXMg
aW5zcGlyZWQgYnkgeDg2IGJpdG9wcw0KPiA+IGltcGxlbWVudGF0aW9uLg0KPiA+DQo+ID4gRUZJ
IHN0dWIgcnVucyBiZWZvcmUgdGhlIGtlcm5lbCwgc28gYWx0ZXJuYXRpdmUgbWVjaGFuaXNtIHNo
b3VsZCBub3QgYmUNCj4gPiB1c2VkIHRoZXJlLCB0aGlzIHBhdGNoIGludHJvZHVjZXMgYSBtYWNy
byBOT19BTFRFUk5BVElWRSBmb3IgdGhpcw0KPiBwdXJwb3NlLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogWGlhbyBXYW5nIDx4aWFvLncud2FuZ0BpbnRlbC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6
IENoYXJsaWUgSmVua2lucyA8Y2hhcmxpZUByaXZvc2luYy5jb20+DQo+IA0KPiBUaGFua3MgZm9y
IHlvdXIgcGF0Y2gsIHdoaWNoIGlzIG5vdyBjb21taXQgNDU3OTI2YjI1MzIwMGJkOSAoInJpc2N2
Og0KPiBPcHRpbWl6ZSBiaXRvcHMgd2l0aCBaYmIgZXh0ZW5zaW9uIikgaW4gcmlzY3YvZm9yLW5l
eHQuDQo+IA0KPiA+IC0tLSBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vYml0b3BzLmgNCj4gPiAr
KysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2JpdG9wcy5oDQo+ID4gQEAgLTE1LDEzICsxNSwy
NjEgQEANCj4gPiAgI2luY2x1ZGUgPGFzbS9iYXJyaWVyLmg+DQo+ID4gICNpbmNsdWRlIDxhc20v
Yml0c3BlcmxvbmcuaD4NCj4gPg0KPiA+ICsjaWYgIWRlZmluZWQoQ09ORklHX1JJU0NWX0lTQV9a
QkIpIHx8IGRlZmluZWQoTk9fQUxURVJOQVRJVkUpDQo+ID4gICNpbmNsdWRlIDxhc20tZ2VuZXJp
Yy9iaXRvcHMvX19mZnMuaD4NCj4gPiAtI2luY2x1ZGUgPGFzbS1nZW5lcmljL2JpdG9wcy9mZnou
aD4NCj4gPiAtI2luY2x1ZGUgPGFzbS1nZW5lcmljL2JpdG9wcy9mbHMuaD4NCj4gPiAgI2luY2x1
ZGUgPGFzbS1nZW5lcmljL2JpdG9wcy9fX2Zscy5oPg0KPiA+ICsjaW5jbHVkZSA8YXNtLWdlbmVy
aWMvYml0b3BzL2Zmcy5oPg0KPiA+ICsjaW5jbHVkZSA8YXNtLWdlbmVyaWMvYml0b3BzL2Zscy5o
Pg0KPiA+ICsNCj4gPiArI2Vsc2UNCj4gPiArI2luY2x1ZGUgPGFzbS9hbHRlcm5hdGl2ZS1tYWNy
b3MuaD4NCj4gPiArI2luY2x1ZGUgPGFzbS9od2NhcC5oPg0KPiA+ICsNCj4gPiArI2lmIChCSVRT
X1BFUl9MT05HID09IDY0KQ0KPiA+ICsjZGVmaW5lIENUWlcgICAiY3R6dyAiDQo+ID4gKyNkZWZp
bmUgQ0xaVyAgICJjbHp3ICINCj4gPiArI2VsaWYgKEJJVFNfUEVSX0xPTkcgPT0gMzIpDQo+ID4g
KyNkZWZpbmUgQ1RaVyAgICJjdHogIg0KPiA+ICsjZGVmaW5lIENMWlcgICAiY2x6ICINCj4gPiAr
I2Vsc2UNCj4gPiArI2Vycm9yICJVbmV4cGVjdGVkIEJJVFNfUEVSX0xPTkciDQo+ID4gKyNlbmRp
Zg0KPiA+ICsNCj4gPiArc3RhdGljIF9fYWx3YXlzX2lubGluZSB1bnNpZ25lZCBsb25nIHZhcmlh
YmxlX19mZnModW5zaWduZWQgbG9uZyB3b3JkKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBpbnQgbnVt
Ow0KPiA+ICsNCj4gPiArICAgICAgIGFzbV92b2xhdGlsZV9nb3RvKEFMVEVSTkFUSVZFKCJqICVs
W2xlZ2FjeV0iLCAibm9wIiwgMCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFJJU0NWX0lTQV9FWFRfWkJCLCAxKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgOiA6IDogOiBsZWdhY3kpOw0KPiA+ICsNCj4gPiArICAgICAgIGFzbSB2b2xhdGlsZSAoIi5v
cHRpb24gcHVzaFxuIg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAiLm9wdGlvbiBhcmNoLCt6
YmJcbiINCj4gPiArICAgICAgICAgICAgICAgICAgICAgImN0eiAlMCwgJTFcbiINCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgIi5vcHRpb24gcG9wXG4iDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIDogIj1yIiAod29yZCkgOiAiciIgKHdvcmQpIDopOw0KPiA+ICsNCj4gPiArICAgICAgIHJl
dHVybiB3b3JkOw0KPiA+ICsNCj4gPiArbGVnYWN5Og0KPiA+ICsgICAgICAgbnVtID0gMDsNCj4g
PiArI2lmIEJJVFNfUEVSX0xPTkcgPT0gNjQNCj4gPiArICAgICAgIGlmICgod29yZCAmIDB4ZmZm
ZmZmZmYpID09IDApIHsNCj4gPiArICAgICAgICAgICAgICAgbnVtICs9IDMyOw0KPiA+ICsgICAg
ICAgICAgICAgICB3b3JkID4+PSAzMjsNCj4gPiArICAgICAgIH0NCj4gPiArI2VuZGlmDQo+ID4g
KyAgICAgICBpZiAoKHdvcmQgJiAweGZmZmYpID09IDApIHsNCj4gPiArICAgICAgICAgICAgICAg
bnVtICs9IDE2Ow0KPiA+ICsgICAgICAgICAgICAgICB3b3JkID4+PSAxNjsNCj4gPiArICAgICAg
IH0NCj4gPiArICAgICAgIGlmICgod29yZCAmIDB4ZmYpID09IDApIHsNCj4gPiArICAgICAgICAg
ICAgICAgbnVtICs9IDg7DQo+ID4gKyAgICAgICAgICAgICAgIHdvcmQgPj49IDg7DQo+ID4gKyAg
ICAgICB9DQo+ID4gKyAgICAgICBpZiAoKHdvcmQgJiAweGYpID09IDApIHsNCj4gPiArICAgICAg
ICAgICAgICAgbnVtICs9IDQ7DQo+ID4gKyAgICAgICAgICAgICAgIHdvcmQgPj49IDQ7DQo+ID4g
KyAgICAgICB9DQo+ID4gKyAgICAgICBpZiAoKHdvcmQgJiAweDMpID09IDApIHsNCj4gPiArICAg
ICAgICAgICAgICAgbnVtICs9IDI7DQo+ID4gKyAgICAgICAgICAgICAgIHdvcmQgPj49IDI7DQo+
ID4gKyAgICAgICB9DQo+ID4gKyAgICAgICBpZiAoKHdvcmQgJiAweDEpID09IDApDQo+ID4gKyAg
ICAgICAgICAgICAgIG51bSArPSAxOw0KPiA+ICsgICAgICAgcmV0dXJuIG51bTsNCj4gPiArfQ0K
PiANCj4gU3VyZWx5IHdlIGNhbiBkbyBiZXR0ZXIgdGhhbiBkdXBsaWNhdGluZyBpbmNsdWRlL2Fz
bS1nZW5lcmljL2JpdG9wcy9fX2Zmcy5oPw0KPiANCj4gRS5nLiByZW5hbWUgdGhlIGdlbmVyaWMg
aW1wbGVtZW50YXRpb24gdG8gZ2VuZXJpY19fX2ZmcygpOg0KPiANCj4gICAgIC1zdGF0aWMgX19h
bHdheXNfaW5saW5lIHVuc2lnbmVkIGxvbmcgX19mZnModW5zaWduZWQgbG9uZyB3b3JkKQ0KPiAg
ICAgK3N0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdW5zaWduZWQgbG9uZyBnZW5lcmljX19mZnModW5z
aWduZWQgbG9uZyB3b3JkKQ0KPiAgICAgIHsNCj4gICAgICAgICAgICAgIC4uLg0KPiAgICAgIH0N
Cj4gDQo+ICAgICArI2lmbmRlZiBfX2Zmcw0KPiAgICAgKyNkZWZpbmUgX19mZnMoeCkgZ2VuZXJp
Y19fZmZzKHgpDQo+ICAgICArI2VuZGlmDQo+IA0KPiBhbmQgZXhwbGljaXRseSBjYWxsaW5nIHRo
ZSBnZW5lcmljIG9uZSBoZXJlPw0KPiANCj4gU2FtZSBjb21tZW50IGZvciB0aGUgb3RoZXIgZnVu
Y3Rpb25zLg0KDQpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLiBJIGp1c3QgdHJpZWQgeW91ciBh
Ym92ZSBleGFtcGxlIGFuZCBnb3QgYnVpbGQgZXJyb3Igb2YNCiJfX2ZmcyIgcmVkZWZpbml0aW9u
LCBJIHRoaW5rIHdlIGNhbiBjaGFuZ2UgdGhlIG1hY3JvIGNvbmRpdGlvbiB0bzoNCg0KKyNpZm5k
ZWYgX19IQVZFX0FSQ0hfX19GRlMNCisjZGVmaW5lIF9fZmZzKHdvcmQpIGdlbmVyaWNfX19mZnMo
d29yZCkNCisjZW5kaWYNCg0KQmVzaWRlcywgYWRkaW5nIGEgImdlbmVyaWNfIiBwcmVmaXggdG8g
X19mZnMgd291bGQgbWFrZSBpdCBhcyAiZ2VuZXJpY19fX2ZmcyIuDQpJIHNhdyBzaW1pbGFyIEFQ
SSBuYW1lcyBpbiBpbmNsdWRlL2FzbS1nZW5lcmljL2JpdG9wcy9nZW5lcmljLW5vbi1hdG9taWMu
aC4NCg0KSSB3b3VsZCBzZW5kIGEgcGF0Y2ggZm9yIHRoaXMuDQoNCkJScywNClhpYW8NCg0KPiAN
Cj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVy
dA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51
eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC0NCj4gbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNv
bmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEg
aGFja2VyLiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5
ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQo=

