Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579327AE838
	for <lists+linux-efi@lfdr.de>; Tue, 26 Sep 2023 10:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjIZIkP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Sep 2023 04:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjIZIkO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Sep 2023 04:40:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56541DE;
        Tue, 26 Sep 2023 01:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695717607; x=1727253607;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aZutH2wuPiUGEWl+2Fw7mnaQcd5WEUeQoN4jg+I3PWU=;
  b=YKe6x5yjrZ7JTXZgbQvhqoI10ue1CEztkN5Q9oLyZcVGv6Un0KWQJw5X
   UInc21dflIpejvaSN55eLvzwg1RgBp9OfGZH3WEuoQs3B0afr6pzmid6z
   xWGi3YIiN0dfyAR3UB+fWKMSnR6NsgxortQUcggbklLHokU5IvmFzpd5M
   Vjp/yTSukICrvBqIeDU93voxSW3X4n+Z6oMG/YoUJwS+EtSDaaSF7iC7i
   4pN/+qNPvzoTrE3S+Tpky0DSlD8PXQmUAXhO5xG8RUcwobkR0+8K3BeUS
   kNIGr49Eda6VFUH/2/Fv20/uWwBqgu34gZP2tAdrZK0MgS44RrvubyKJj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="467802989"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="467802989"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:40:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="725364535"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="725364535"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 01:40:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 01:40:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 01:40:05 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 01:40:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6/94YPGqxsS3tlEt42rKBt9biwZXt5FzzVc2KltX4XI6xyq6oWy6ut/QpZkrIhVXgUI3787cOXD92c/Aueij9jARLdE9AwYyt8h1F19s0ANp5dwoMoLu8AAoEUpou9aa68I2vPeBaedjXshAqLX9mnvxHAkxkGfbaXVx9w03XDQVInRbHmR0XG5ALReoGZ7+4+ldTHS1PSxqzWHyTrfuReno4qhZb6ZzB5BC5ULbJ0SEn5AZeqlhRGkORUQAzpFqmyx3qejeaHFpyrE5H2g9s2YJv4x6tBwL0Ij9jX37oRoRy5sD1dBhs9bA0/19jIcCp4R5eXUkgbBL9hdU6P9VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejwSKbgB2jekh55nfVQoEUare98mRwZOVqWFDxOBRKs=;
 b=c+aQsJKBaW6Zd0bzVaG1rg8Xl9rkC4oc8Oa/uqiHUNcguG8FSO3ANaTJbBrrMxme/jfqg8fnUiIrTbsJ1Vv2MMLp5a9lPCmkrBogOAImTZdb+JUymTxcs68orDhIhlTXBOIuEzzuSVssh51OofdqR6q0HVif75By2MZw1RzHtQ2zb7DHBTWxqy/hqrT7ibcdi+VPKr7S8KpqMgykZwBy1TyzzkjLejUi5MTKJqqKeD3mregeNij00A7hlcfD9dEg15xFLmH+czacFMjS9lbrag8LnXrb9NgVOlC9b5uBGV8LaJC/Jw9emmULonhCA7YDqrLhvj3CWWStqy1IAOZBhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 CH0PR11MB8216.namprd11.prod.outlook.com (2603:10b6:610:192::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 26 Sep
 2023 08:39:57 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::7bf2:1b4c:1512:79c1]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::7bf2:1b4c:1512:79c1%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 08:39:57 +0000
From:   "Wang, Xiao W" <xiao.w.wang@intel.com>
To:     "Liu, Yujie" <yujie.liu@intel.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "ardb@kernel.org" <ardb@kernel.org>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "Li, Haicheng" <haicheng.li@intel.com>,
        "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] riscv: Rearrange hwcap.h and cpufeature.h
Thread-Topic: [PATCH v2 1/2] riscv: Rearrange hwcap.h and cpufeature.h
Thread-Index: AQHZ65WuWzl+MqTPrUSnUbL8bC93HrAsq0EAgAAixRA=
Date:   Tue, 26 Sep 2023 08:39:56 +0000
Message-ID: <DM8PR11MB5751453D6287F2A3A0646C9AB8C3A@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20230920074653.2509631-2-xiao.w.wang@intel.com>
 <202309201921.GvBmYK5q-lkp@intel.com>
In-Reply-To: <202309201921.GvBmYK5q-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|CH0PR11MB8216:EE_
x-ms-office365-filtering-correlation-id: b9ed5f93-3de7-4528-4091-08dbbe6c29cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NQfq4MIPwtLtD6Ajpq1P0yEna4OO7a9pH+NHNVy8iwvNV5/2Pws/+6vLb+dsznIyeK9ESxq3r5DslR6VUwzTcMOC9Pta9pQnCrCYo9LaqDEYV8FcwHNrKmluCXeeALX7S23LK43TqtxNOp4l8Kynt7jBOa2xjDfnKDoru9P1u/JiG6Yr9KYS017SdzYOlEWcpx6qHKdidqKuuzLlosvpzAbJFFc0t+0KRqXFIhSDuJp4yMQARWKi3G+ImBH05NtuSOvyM5Gwn8bbA3yCqFEklbds+gbea7pHIOnuuZ6ORVErFQqappFZQ4WquxzYglzaasjwM7a41GsMfgVdz7Fv3/WvpYetDzDV2Apj3jcQQJ8ixuHrj8SRRRPm6sYj169x0lDS+9+oQ7aSVRL2mUZp0JpaKvavC+CQwEfx4hkiPS4F9kQ22UgTsKRoS2BkMCCtaf6IrmC3DiKvCKMjcukPK+wa4/br7g7YnrNOu7lf6s+XkdHjEaL7rEvq+QvAfbp8mdatlN+zcrhHZFLf6PcBzcDdtC0H9Ip3w7sB39R6WR6b9LXhpxTqFbIxjdPZdHfzlpvnYItoP8gacqn1wJWFV2x3Y4Oe1vFijEgDxB6rkpoqBV+h9nrWXgOCL+j8sqYwA2k6EWHZkR+TrJNGps4+zQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(346002)(366004)(230922051799003)(451199024)(186009)(1800799009)(53546011)(8676002)(83380400001)(478600001)(76116006)(110136005)(64756008)(66446008)(66476007)(66556008)(66946007)(6506007)(71200400001)(54906003)(9686003)(52536014)(8936002)(7696005)(316002)(966005)(41300700001)(5660300002)(38100700002)(38070700005)(7416002)(82960400001)(4326008)(86362001)(2906002)(55016003)(33656002)(26005)(122000001)(30864003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?FjTGQHM5kEDyCCkdUkDTg32PJ1B1rSvXIi2NKpKdeJAtM8ldkj6cpqYo?=
 =?Windows-1252?Q?FxIr+SHzUDO+FLlE959YEUdZlRJ9k0TllGi1NghB6MVCX7dJ6zNb8oBc?=
 =?Windows-1252?Q?5fL0M3O4xVnUCPEjVE7eaq5dzN6h5jeuf9PjbHvdgFSmCC1wpXHQAhFi?=
 =?Windows-1252?Q?Ti32YfCCPzkKgz0hFDnRB1x+pxY+pSoeAgBvo8sUDH0S0CUiBmLQ7BTa?=
 =?Windows-1252?Q?Z8mIJgUzNTuhh3nkvviX5GdZ4VHW3BiB4ykOXGtL1W4bm9DdX+iy8WVm?=
 =?Windows-1252?Q?H77iX0zrjgGVorwpchvfpxIIQyqLRTreoQSpAaXJOmKblbb2bIl93iDi?=
 =?Windows-1252?Q?YZMT+cG7rip3FJ8SkPZVx0j6J9Dp7wm+U92xKUqPeKDKFIDWicQdqUyt?=
 =?Windows-1252?Q?zedos9Yv0KTMN8Hhr4bwL8bE1X5K19p6h2a9RkQqLyCi3+CffV8hBvSB?=
 =?Windows-1252?Q?g15C2rH+GqtNQrmSqrrH40iiCBqGq7k4P6bfi44oq0XPt39zC40TRImA?=
 =?Windows-1252?Q?m7CfKrsdWScwieJTYvIa3nm0EJtfLiAIQOP89t26zkidwNUrNQoq2w8/?=
 =?Windows-1252?Q?xZxdvHGWcpxs9fKUjQb1XzXbEbDPpPdPlJUffh2DzgEsgQb5V7fErVTy?=
 =?Windows-1252?Q?NYCDI1iqZPSm2QwWjHCeStHkFhYKwl3BxgmJ3ZvLOaE7R36EMbcGgfbv?=
 =?Windows-1252?Q?Gg4XltjSvsdVPZ3n0PB1vULDrpEv/BFBHCvOlbhmvEd+eZF24hdaEQzh?=
 =?Windows-1252?Q?jmbhMXPOtESw9ZjPaZip+Fet5hRdCEB5uCx3+D8N9Ou2yWf+tcixeYYT?=
 =?Windows-1252?Q?f7NYMtyZxGcFzfXHNF8Dq9tAaUM1LhUTEDKIxul0Ezp9jIkjb3nSwjlg?=
 =?Windows-1252?Q?y6d9tXV6bgur7wJzC+LVeXfxFLtvidlgo0jxB4kLt/+j3TawrTN11zD3?=
 =?Windows-1252?Q?Mj2OfY5byomYQooDCEHcD48lwj3bnPj7x9Rf5vFxTtfufwhPvoyY2r6M?=
 =?Windows-1252?Q?Moxf0OMNNlYYzfW6n9yMAWtsz9jGkpHvmbsjyd4Ieqytrjs+IATXymWA?=
 =?Windows-1252?Q?fnxOddsldyG6T7EBXIyR+AXP35GKbcGqcGEtDkPErm0E6AxMMhvP5U/2?=
 =?Windows-1252?Q?L7z8EhMng6oCzXUv3DT0ez/gg6QDYjTiN/14hdZPbQPoN5t4JT5Ffbl9?=
 =?Windows-1252?Q?wH/F4l5bsLvyiR013lnxuDxqZLXUCCfd0KfbEoww/AF3qlhzjAHOrjnc?=
 =?Windows-1252?Q?MGSqdbIRgGgeRxAQaEY7VjNt8FvGDB++zYCn61OK6S82cIe3Enfn5/ba?=
 =?Windows-1252?Q?5IDNxuq5cDgMHITiHnmckTPXZ2qOAbj+oa7CxIvtXrCXZ2ljnHCfqlSq?=
 =?Windows-1252?Q?8XMkHjnY24hzku74zSKAd5mdrQmyEviXOZinUWulMWwIaRSPf47pJg3E?=
 =?Windows-1252?Q?OmVjrl8bk214Xhk65Aab3AuHEcI5pPCf50Ez05rNJEZEl7Ya3MGUCERM?=
 =?Windows-1252?Q?GabJSeXzBBDkU/MUFDPNIWGS3TKYSze9NGFe0E3Je6STSQxE9V0HHUds?=
 =?Windows-1252?Q?aj/kUcSJNsySoWTOhiYT+dOngwMXA1W1mkYsNlDtkh0zdxihsOalvnzy?=
 =?Windows-1252?Q?TybE9A2zIvKTxxXic9sjnJGNTFeH1vfwCjioM45YC5C+V1wtD25/x0Fs?=
 =?Windows-1252?Q?RUL4OsIWz9hAWTFwHCKEb+AYrqNebugj?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ed5f93-3de7-4528-4091-08dbbe6c29cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 08:39:56.9856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wDS3u5VVtiI7/7oLJROP91mzdOHQ6BoUS3VlBm421vctefpAVJM7M1QDare9p4y0Vajxw67LtoUWpEk0o01fSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8216
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Yujie,

I would fix the riscv32 build issue in v3.=20
I checked some *.o.cmd files from riscv64 build and see that cpufeature.h i=
s indirectly included there, but it's not for riscv32 build.
I need to change "hwcap.h" to "cpufeature.h" for all places where cpu featu=
re detection APIs are called.
=20
Thanks for the info.

BRs,
Xiao

> -----Original Message-----
> From: Liu, Yujie <yujie.liu@intel.com>
> Sent: Tuesday, September 26, 2023 2:18 PM
> To: Wang, Xiao W <xiao.w.wang@intel.com>; paul.walmsley@sifive.com;
> palmer@dabbelt.com; aou@eecs.berkeley.edu; ardb@kernel.org
> Cc: oe-kbuild-all@lists.linux.dev; anup@brainfault.org; Li, Haicheng
> <haicheng.li@intel.com>; ajones@ventanamicro.com; linux-
> riscv@lists.infradead.org; linux-efi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Wang, Xiao W <xiao.w.wang@intel.com>
> Subject: Re: [PATCH v2 1/2] riscv: Rearrange hwcap.h and cpufeature.h
>=20
> Hi Xiao,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.6-rc2 next-20230920]
> [cannot apply to efi/next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Xiao-Wang/riscv-
> Rearrange-hwcap-h-and-cpufeature-h/20230920-154024
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20230920074653.2509631-2-
> xiao.w.wang%40intel.com
> patch subject: [PATCH v2 1/2] riscv: Rearrange hwcap.h and cpufeature.h
> config: riscv-rv32_defconfig (https://download.01.org/0day-
> ci/archive/20230920/202309201921.GvBmYK5q-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-
> ci/archive/20230920/202309201921.GvBmYK5q-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Closes: https://lore.kernel.org/r/202309201921.GvBmYK5q-
> lkp@intel.com/
>=20
> All errors (new ones prefixed by >>):
>=20
>    fs/binfmt_elf.c: In function 'create_elf_tables':
> >> arch/riscv/include/asm/elf.h:70:25: error: implicit declaration of fun=
ction
> 'riscv_get_elf_hwcap'; did you mean 'riscv_fill_hwcap'? [-Werror=3Dimplic=
it-
> function-declaration]
>       70 | #define ELF_HWCAP       riscv_get_elf_hwcap()
>          |                         ^~~~~~~~~~~~~~~~~~~
>    fs/binfmt_elf.c:248:31: note: in definition of macro 'NEW_AUX_ENT'
>      248 |                 *elf_info++ =3D val; \
>          |                               ^~~
>    fs/binfmt_elf.c:260:31: note: in expansion of macro 'ELF_HWCAP'
>      260 |         NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
>          |                               ^~~~~~~~~
>    cc1: some warnings being treated as errors
> --
>    arch/riscv/kvm/main.c: In function 'riscv_kvm_init':
> >> arch/riscv/kvm/main.c:73:14: error: implicit declaration of function
> 'riscv_isa_extension_available' [-Werror=3Dimplicit-function-declaration]
>       73 |         if (!riscv_isa_extension_available(NULL, h)) {
>          |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> arch/riscv/kvm/main.c:73:50: error: 'h' undeclared (first use in this
> function)
>       73 |         if (!riscv_isa_extension_available(NULL, h)) {
>          |                                                  ^
>    arch/riscv/kvm/main.c:73:50: note: each undeclared identifier is repor=
ted
> only once for each function it appears in
>    cc1: some warnings being treated as errors
> --
>    arch/riscv/kvm/tlb.c: In function 'kvm_riscv_local_hfence_gvma_vmid_gp=
a':
> >> arch/riscv/kvm/tlb.c:18:25: error: implicit declaration of function
> 'riscv_has_extension_unlikely' [-Werror=3Dimplicit-function-declaration]
>       18 | #define has_svinval()
> riscv_has_extension_unlikely(RISCV_ISA_EXT_SVINVAL)
>          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/riscv/kvm/tlb.c:31:13: note: in expansion of macro 'has_svinval'
>       31 |         if (has_svinval()) {
>          |             ^~~~~~~~~~~
>    cc1: some warnings being treated as errors
> --
>    arch/riscv/kvm/vcpu_fp.c: In function 'kvm_riscv_vcpu_fp_reset':
> >> arch/riscv/kvm/vcpu_fp.c:22:13: error: implicit declaration of functio=
n
> 'riscv_isa_extension_available' [-Werror=3Dimplicit-function-declaration]
>       22 |         if (riscv_isa_extension_available(vcpu->arch.isa, f) |=
|
>          |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> arch/riscv/kvm/vcpu_fp.c:22:59: error: 'f' undeclared (first use in th=
is
> function); did you mean 'fd'?
>       22 |         if (riscv_isa_extension_available(vcpu->arch.isa, f) |=
|
>          |                                                           ^
>          |                                                           fd
>    arch/riscv/kvm/vcpu_fp.c:22:59: note: each undeclared identifier is re=
ported
> only once for each function it appears in
> >> arch/riscv/kvm/vcpu_fp.c:23:59: error: 'd' undeclared (first use in th=
is
> function); did you mean 'fd'?
>       23 |             riscv_isa_extension_available(vcpu->arch.isa, d))
>          |                                                           ^
>          |                                                           fd
>    arch/riscv/kvm/vcpu_fp.c: In function 'kvm_riscv_vcpu_guest_fp_save':
>    arch/riscv/kvm/vcpu_fp.c:39:56: error: 'd' undeclared (first use in th=
is
> function); did you mean 'fd'?
>       39 |                 if (riscv_isa_extension_available(isa, d))
>          |                                                        ^
>          |                                                        fd
>    arch/riscv/kvm/vcpu_fp.c:41:61: error: 'f' undeclared (first use in th=
is
> function); did you mean 'fd'?
>       41 |                 else if (riscv_isa_extension_available(isa, f)=
)
>          |                                                             ^
>          |                                                             fd
>    arch/riscv/kvm/vcpu_fp.c: In function 'kvm_riscv_vcpu_guest_fp_restore=
':
>    arch/riscv/kvm/vcpu_fp.c:51:56: error: 'd' undeclared (first use in th=
is
> function); did you mean 'fd'?
>       51 |                 if (riscv_isa_extension_available(isa, d))
>          |                                                        ^
>          |                                                        fd
>    arch/riscv/kvm/vcpu_fp.c:53:61: error: 'f' undeclared (first use in th=
is
> function); did you mean 'fd'?
>       53 |                 else if (riscv_isa_extension_available(isa, f)=
)
>          |                                                             ^
>          |                                                             fd
>    arch/riscv/kvm/vcpu_fp.c: In function 'kvm_riscv_vcpu_host_fp_save':
>    arch/riscv/kvm/vcpu_fp.c:62:49: error: 'd' undeclared (first use in th=
is
> function); did you mean 'fd'?
>       62 |         if (riscv_isa_extension_available(NULL, d))
>          |                                                 ^
>          |                                                 fd
>    arch/riscv/kvm/vcpu_fp.c:64:54: error: 'f' undeclared (first use in th=
is
> function); did you mean 'fd'?
>       64 |         else if (riscv_isa_extension_available(NULL, f))
>          |                                                      ^
>          |                                                      fd
>    arch/riscv/kvm/vcpu_fp.c: In function 'kvm_riscv_vcpu_host_fp_restore'=
:
>    arch/riscv/kvm/vcpu_fp.c:70:49: error: 'd' undeclared (first use in th=
is
> function); did you mean 'fd'?
>       70 |         if (riscv_isa_extension_available(NULL, d))
>          |                                                 ^
>          |                                                 fd
>    arch/riscv/kvm/vcpu_fp.c:72:54: error: 'f' undeclared (first use in th=
is
> function); did you mean 'fd'?
>       72 |         else if (riscv_isa_extension_available(NULL, f))
>          |                                                      ^
>          |                                                      fd
>    arch/riscv/kvm/vcpu_fp.c: In function 'kvm_riscv_vcpu_get_reg_fp':
>    arch/riscv/kvm/vcpu_fp.c:90:59: error: 'f' undeclared (first use in th=
is
> function); did you mean 'fd'?
>       90 |             riscv_isa_extension_available(vcpu->arch.isa, f)) =
{
>          |                                                           ^
>          |                                                           fd
>    arch/riscv/kvm/vcpu_fp.c:101:66: error: 'd' undeclared (first use in t=
his
> function); did you mean 'fd'?
>      101 |                    riscv_isa_extension_available(vcpu->arch.is=
a, d)) {
>          |                                                               =
   ^
>          |                                                               =
   fd
>    arch/riscv/kvm/vcpu_fp.c: In function 'kvm_riscv_vcpu_set_reg_fp':
>    arch/riscv/kvm/vcpu_fp.c:135:59: error: 'f' undeclared (first use in t=
his
> function); did you mean 'fd'?
>      135 |             riscv_isa_extension_available(vcpu->arch.isa, f)) =
{
>          |                                                           ^
>          |                                                           fd
>    arch/riscv/kvm/vcpu_fp.c:146:66: error: 'd' undeclared (first use in t=
his
> function); did you mean 'fd'?
>      146 |                    riscv_isa_extension_available(vcpu->arch.is=
a, d)) {
>          |                                                               =
   ^
>          |                                                               =
   fd
>    cc1: some warnings being treated as errors
> --
>    arch/riscv/kvm/vcpu_timer.c: In function 'kvm_riscv_vcpu_timer_init':
> >> arch/riscv/kvm/vcpu_timer.c:256:13: error: implicit declaration of fun=
ction
> 'riscv_isa_extension_available' [-Werror=3Dimplicit-function-declaration]
>      256 |         if (riscv_isa_extension_available(NULL, SSTC)) {
>          |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> arch/riscv/kvm/vcpu_timer.c:256:49: error: 'SSTC' undeclared (first us=
e in
> this function)
>      256 |         if (riscv_isa_extension_available(NULL, SSTC)) {
>          |                                                 ^~~~
>    arch/riscv/kvm/vcpu_timer.c:256:49: note: each undeclared identifier i=
s
> reported only once for each function it appears in
>    cc1: some warnings being treated as errors
> --
>    arch/riscv/kvm/vcpu_pmu.c: In function 'kvm_riscv_vcpu_pmu_init':
> >> arch/riscv/kvm/vcpu_pmu.c:556:14: error: implicit declaration of funct=
ion
> 'riscv_isa_extension_available' [-Werror=3Dimplicit-function-declaration]
>      556 |         if (!riscv_isa_extension_available(NULL, SSCOFPMF))
>          |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> arch/riscv/kvm/vcpu_pmu.c:556:50: error: 'SSCOFPMF' undeclared (first
> use in this function)
>      556 |         if (!riscv_isa_extension_available(NULL, SSCOFPMF))
>          |                                                  ^~~~~~~~
>    arch/riscv/kvm/vcpu_pmu.c:556:50: note: each undeclared identifier is
> reported only once for each function it appears in
>    cc1: some warnings being treated as errors
> --
>    arch/riscv/kvm/aia.c: In function 'kvm_riscv_aia_init':
> >> arch/riscv/kvm/aia.c:604:14: error: implicit declaration of function
> 'riscv_isa_extension_available' [-Werror=3Dimplicit-function-declaration]
>      604 |         if (!riscv_isa_extension_available(NULL, SxAIA))
>          |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> arch/riscv/kvm/aia.c:604:50: error: 'SxAIA' undeclared (first use in t=
his
> function)
>      604 |         if (!riscv_isa_extension_available(NULL, SxAIA))
>          |                                                  ^~~~~
>    arch/riscv/kvm/aia.c:604:50: note: each undeclared identifier is repor=
ted
> only once for each function it appears in
>    cc1: some warnings being treated as errors
> --
>    drivers/perf/riscv_pmu_sbi.c: In function 'pmu_sbi_setup_irqs':
> >> drivers/perf/riscv_pmu_sbi.c:803:13: error: implicit declaration of fu=
nction
> 'riscv_isa_extension_available' [-Werror=3Dimplicit-function-declaration]
>      803 |         if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
>          |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/perf/riscv_pmu_sbi.c:803:49: error: 'SSCOFPMF' undeclared (fir=
st
> use in this function)
>      803 |         if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
>          |                                                 ^~~~~~~~
>    drivers/perf/riscv_pmu_sbi.c:803:49: note: each undeclared identifier =
is
> reported only once for each function it appears in
>    cc1: some warnings being treated as errors
>=20
>=20
> vim +70 arch/riscv/include/asm/elf.h
>=20
> 2350bd192fa2d9 Palmer Dabbelt 2023-02-02  64
> 2129a235c09896 Palmer Dabbelt 2017-07-10  65  /*
> 2350bd192fa2d9 Palmer Dabbelt 2023-02-02  66   * Provides information on
> the availiable set of ISA extensions to userspace,
> 2350bd192fa2d9 Palmer Dabbelt 2023-02-02  67   * via a bitmap that
> coorespends to each single-letter ISA extension.  This is
> 2350bd192fa2d9 Palmer Dabbelt 2023-02-02  68   * essentially defunct, but
> will remain for compatibility with userspace.
> 2129a235c09896 Palmer Dabbelt 2017-07-10  69   */
> 50724efcb370c6 Andy Chiu      2023-06-05 @70  #define ELF_HWCAP
> 	riscv_get_elf_hwcap()
> 2129a235c09896 Palmer Dabbelt 2017-07-10  71  extern unsigned long
> elf_hwcap;
> 2129a235c09896 Palmer Dabbelt 2017-07-10  72
>=20
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

