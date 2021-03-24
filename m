Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9148347D15
	for <lists+linux-efi@lfdr.de>; Wed, 24 Mar 2021 16:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbhCXPzL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 24 Mar 2021 11:55:11 -0400
Received: from mail-mw2nam10on2108.outbound.protection.outlook.com ([40.107.94.108]:29248
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236824AbhCXPzB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 24 Mar 2021 11:55:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktXN89rllrMHIKLiNxH16HEfN4oun/01uFmz+i58rWSG2FYfLDwASVGqWoD5tujtUNxXo8kbRogcC/36z66cySb9IWIrtzcz0YTzWrJEaOVyge/TaOFaVCfhIUT4mqew9WCsTFJFSPsO0m0fTZfGArFiqs9iWteYlpy2oHq7ZZRMFYZlalldkdVxWF52VqJPFVxb9lpdg3DBlqphxbP0paD2M2oh1eFqNfh93EmUtNMZIAEQsKyQNvIbSdxvthdiJSmLewGy7c876dw9DgSKATA8vLTL8KupS5uXGG5hTU5/GV4eEwy9n/y5K8IaCszw0LvqZ6Xryg0mQ2yfxNfX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVMm+S7rlTUx294O59Vk6cQMS+bntGuxoIhG3+MkvBU=;
 b=SWpFnPRW7Mz7nFjdyfFVf3V5UqxZM5vG4aJhHpEM/6l/OUsOPY4LaJ8fBjzdfDZJp8RaaQYXSsWsxrykpyJ68oQYjiyyTfKqB4YCDL078buGG0HPdvan4JZ/bqSuMZ0nE9fspPnJ5Bm9AQ9BQOhgXQxBy/r9mD3f3Mw2cNSRVjdlYBSItuEBrtvUek9E2zLON1MjkxYvyLsL6QP7cnXl68gOicmVqYkyoTN6KB0vucstGD5gmzrM19zF+H0qbZt7QhPUmSQW4+/YisrdbtvbT7OIL4UrxcDB08aZoCFcfbrPTMnwYDa3bRnXz84xw/fJiYV/Jo2j2gXjQX28pts8ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVMm+S7rlTUx294O59Vk6cQMS+bntGuxoIhG3+MkvBU=;
 b=Vs0YqwnMr9D8ZxgDie4c80alCFmr5/YwTdcXxkKfydhz3e5/YX2BJbpGh9T1nvMJeMHEahG1I1DJrcZgUq2+Up7lO935YK6HxtWbnqLQyWOVeYdXdgx7yRSXX+bjkIpCNLkOmne4JKI7FzBHWHWMo5jaWE1npn0IGAW0VxqbXtw=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1890.namprd21.prod.outlook.com (2603:10b6:303:64::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.1; Wed, 24 Mar
 2021 15:54:59 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cbc:735e:a6a5:8b9c]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cbc:735e:a6a5:8b9c%8]) with mapi id 15.20.3999.004; Wed, 24 Mar 2021
 15:54:59 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH v9 0/7] Enable Linux guests on Hyper-V on ARM64
Thread-Topic: [PATCH v9 0/7] Enable Linux guests on Hyper-V on ARM64
Thread-Index: AQHXFFVaB5wOH2JbNEut11B5j7WvKqqTYJ2g
Date:   Wed, 24 Mar 2021 15:54:59 +0000
Message-ID: <MWHPR21MB1593E68A0032D7344A42BD0DD7639@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1615233439-23346-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1615233439-23346-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-24T15:54:56Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6488edde-ca30-4fab-ada2-e40fa988c40f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f4b94836-a5f3-4fc3-d8a0-08d8eedd2d90
x-ms-traffictypediagnostic: MW4PR21MB1890:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB18902682B0163EF10CFA941FD7639@MW4PR21MB1890.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jlgAjbgG7v6YSJHRzNI6RHfdJSgzOoI8tx2dJXU7CkLnQB0njpACTkiml4/ennofuW2ECzVEYp4OV2TNMDjNgKPRvgsOJa9+sIgCd7jLm4pROpQHVWvle9ZDdFiN0C3iNcfOIv/8RICof9OZSIg5kPyzQkSp1y/72w6OnmOyJiQvQXhwJPuLKvQ5hLi57xtkGqTXRvxby9CToXaJExbfO5batcYRsVSz17WuI5m8eN/gSRmjmMzysJhhWLWCPgLyWzIyMia3/qGMBSP1cmtCKoP2gtMTaZ7BsyZVJxchZdsE5H//EWt234khgam8IxiKzZPJMazOJAy663fxDInOqgAbwhkNBWfKOrce5+4vqDXndjA9gQ1QnY9bfXQw+d+GO0FV2ywEykTkdyBFHdErWXImNF5BmAW3hEHTZ+cO84VZAXbgDZwNkheWa5OclPOn3I0Y9AOCWU6kX1S4bCsSRXkT5CRTv5+mBxRa8GxDro1VItIEwFlgB0nq+mPj2WLWii0pSjD4r98rgX41AWLNU3TD2Uf46oxYBZuXbtoyFnJJrBGyka5FURxPLNs59JZYXDUz7/fqrb+feIIGVk+JvbIegqlZ1gw36mkJNa00d0L1Wyj/SFNDLvNvkjFGtQIik9ArP7YJVrPxqvZPymeBU7XepErUrgiPa9lfgt5fqz36MrDUzTtJW1jMfOWUXCqKv3cbprj6PU3gkiIsBuEU7LjSQeKI7lGTB3YuSTuZ4GS8MOkDeg0VxE/QflynhUR0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(4326008)(55016002)(5660300002)(107886003)(7416002)(66556008)(66446008)(9686003)(64756008)(66946007)(76116006)(52536014)(83380400001)(71200400001)(38100700001)(316002)(26005)(54906003)(8936002)(966005)(110136005)(82960400001)(86362001)(478600001)(66476007)(186003)(82950400001)(2906002)(8990500004)(6506007)(33656002)(10290500003)(7696005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UQoD5Yuno1XZA8BnI6cEdB+Zd8JsmO49bOHOUoRGohB/WRhwqlq9mqxU9v0c?=
 =?us-ascii?Q?VYwsKE3SoBIGFxEBxnU1nV+Tu7dmjGXXrb6h6pi7ROwF1idcTngtGcXJtyfk?=
 =?us-ascii?Q?jhN8ib+sAE1qxWpiuCvWCuX1qfR/dFIP4WMGd5ZYEMrBbXqhOaOU7FOYjMq+?=
 =?us-ascii?Q?14LVq2qkta8Esdrxb01SGfI+Lr0dV2OpR2GIa/By/Y7YzKypPJRartpafATw?=
 =?us-ascii?Q?VH4kKmsu+sNA6C9Z5Zjkt6YWUUQa57P2MM0HEhF5JvxJsi4LUY16/EFCeVZB?=
 =?us-ascii?Q?DGbx3ReFG9Jirdj1Z5SGj3CJIcoiM1Dh66kaRBv5EvhlibOuqVlJtNsqu4zf?=
 =?us-ascii?Q?zKDqHusKvYreeweWGbHu7V6eABHko04/7UQHb65/UCUq5zOZN+kIT9zTPv9k?=
 =?us-ascii?Q?ZWHq7b6WZXe5pIYtVKdD7IosuvULPoOzjIKVlMy9/t5IK7GNzwW7NfUMYHJz?=
 =?us-ascii?Q?JiiyGI4gOmyh6cS0P1E5gEg67Qew1CG90xPawOjbHjzmLIiRuYeoo63eLXVe?=
 =?us-ascii?Q?/Brpbv44hPh/nNG+vOZvrYrZVi+1K/e9q1vcR8mPdI/6u/1Up1H9irkjufB3?=
 =?us-ascii?Q?DhjVyMI7SEHUxDRVmEWjte+hH1/9CxU4pKybXRO5BIBeZsikH5hoFnmgDu11?=
 =?us-ascii?Q?6t2ettuaovLX32kj6OYrcEFA0buaYAE140/YOgVC1MqdOKNflkZTtJiZQYOw?=
 =?us-ascii?Q?7P2eaOvPgRTnEvD6xcb2rlQ15Y0wFtmBpxneK9ASnrbrLHGePp8MC7DYsqxn?=
 =?us-ascii?Q?cu3Am+55FceD+kpHQEhOzxPFaIb+qE9ny4c79nMX9m/Q+0IanZjDTleg+6F3?=
 =?us-ascii?Q?EWxzeL5FZkpUW0GkT32laKcGaUsyI25ntFijYYF5F6TweEfrW3eymxROJmpO?=
 =?us-ascii?Q?EMEuGr6nmDIjKgKURBnd1tgqLxxAg4z2LmY7HsvMQuvh+eVz174B61cS21w9?=
 =?us-ascii?Q?F9tc0mk/yK6NJ0/6WEv4KvIiCBy+2qGu4gaGhZEcngveka/gxf2K1m18n7We?=
 =?us-ascii?Q?4buh3m4XuZ6XyTguETpMB4+I6cXVVwEvVTiV4sYjITA+sXeL39KVTZmAqTPp?=
 =?us-ascii?Q?idHMrDDgxN3VCmg8FYbhiydT/NWuMzwT+tjGkliqsvwCMJMvJNQgxYWiHzPw?=
 =?us-ascii?Q?Nuyn8a91c8By88nW5LocoqYs5xnt0RNEoVWJW7LPjAd367S0NAbQp5UFbUlq?=
 =?us-ascii?Q?fHgXtNZzwP4aJJaCKV8qzUzuHXiE61OPZ7kLdrmaT/qt2M5TRTyPYfCRU/aW?=
 =?us-ascii?Q?iUA1uH0j2lgsmWSXPCtCojVXlN4dg/05feWC3JWyq3OlBH37BuyYZmIjzB5I?=
 =?us-ascii?Q?BUDAQ/YsoEmdG5qQd2vTDICb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b94836-a5f3-4fc3-d8a0-08d8eedd2d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 15:54:59.1206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ILe/lWsvG1dsYkZYkSkzHcZjJ3LUQNfltsLRYH6Q5jS8VOn1a8R0vdH/29Ro5tCo9CmQJniHQ8ZQh7Wpb4UGOE3KoWZVFkcb9vkx8k9CDvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1890
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com> Sent: Monday, March 8, 2021 1=
1:57 AM
>=20
> This series enables Linux guests running on Hyper-V on ARM64
> hardware. New ARM64-specific code in arch/arm64/hyperv initializes
> Hyper-V, including its interrupts and hypercall mechanism.
> Existing architecture independent drivers for Hyper-V's VMbus and
> synthetic devices just work when built for ARM64. Hyper-V code is
> built and included in the image and modules only if CONFIG_HYPERV
> is enabled.

ARM64 maintainers --

What are the prospects for getting your review and Ack on this patch set?
We're wanting to get the Hyper-V support on ARM64 finally accepted upstream=
.
Previous comments should be addressed in this revision, with perhaps a
remaining discussion point around the alternate SMCCC hypercall interface
in Patch 1 that makes use of changes in v1.2 of the SMCCC spec.  There are
several viable approaches that I've noted in the patch, depending on
your preferences.

Michael

>=20
> The seven patches are organized as follows:
>=20
> 1) Update include/linux/arm-smccc.h to provide an HVC wrapper
>    variant that returns results in other than X0 thru X3
>=20
> 2) Add definitions and functions for making Hyper-V hypercalls
>    and getting/setting virtual processor registers provided by
>    Hyper-V
>=20
> 3) Add architecture specific definitions needed by the
>    architecture independent Hyper-V clocksource driver in
>    drivers/clocksource/hyperv_timer.c. Update the clocksource
>    driver to be initialized on ARM64.
>=20
> 4) Add functions needed by the arch independent VMbus driver
>    for reporting a panic to Hyper-V and as stubs for the kexec
>    and crash handlers.
>=20
> 5) Add Hyper-V initialization code and utility functions that
>    report Hyper-v status.
>=20
> 6) Export screen_info so it may be used by the Hyper-V frame buffer
>    driver built as a module. It is already exported for x86,
>    powerpc, and alpha architectures.
>=20
> 7) Make CONFIG_HYPERV selectable on ARM64 in addition to x86/x64.
>=20
> Hyper-V on ARM64 runs with a 4 Kbyte page size, but allows guests
> with 4K/16K/64K page size. Linux guests with this ARM64 enablement
> code work with all three supported ARM64 page sizes.
>=20
> The Hyper-V vPCI driver at drivers/pci/host/pci-hyperv.c has
> x86/x64-specific code and is not being built for ARM64. Fixing
> this driver to enable vPCI devices on ARM64 will be done later.
>=20
> In a few cases, terminology from the x86/x64 world has been carried
> over into the ARM64 code ("MSR", "TSC").  Hyper-V still uses the
> x86/x64 terminology and has not replaced it with something more
> generic, so the code uses the Hyper-V terminology.  This will be
> fixed when Hyper-V updates the usage in the TLFS.
>=20
> This patch set is based on the hyperv-next branch of the code tree
> https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/=20
>=20
> Changes in v9:
> * Added Patch 1 to enable making an SMCCC compliant hypercall
>   that returns results in other than registers X0 thru X3, per
>   version 1.2 and later of the SMCCC spec.
> * Using the ability to return results in registers X6 and X7,
>   converted hv_get_vpreg_128() to use a "fast" hypercall that
>   passes inputs and outputs in registers, and in doing so eliminated
>   a lot of memory allocation complexity.
> * Cleaned up some extra blank lines and use of spaces in aligning
>   local variables. [Sunil Muthuswamy]
> * Based on discussion about future directions, reverted the
>   population of hv_vp_index array to use a cpuhp state instead
>   of a hypercall, which is like it was in v7 and earlier.
>=20
> Changes in v8:
> * Removed a lot of code based on refactoring the boundary between
>   arch independent and arch dependent code for Hyper-V, per comments
>   from Arnd Bergmann. The removed code was either duplicated on
>   the x86 side, or has been folded into architecture independent
>   code as not really being architecture dependent.
> * Added config dependency on !CONFIG_CPU_BIG_ENDIAN [Arnd Bergmann]
> * Reworked the approach to Hyper-V initialization. The functionality
>   is the same, but is now structured like the Xen code with an early
>   init function called in setup_arch() and an early initcall to
>   finish the initialization. [Arnd Bergmann]
>=20
> Changes in v7:
> * Separately upstreamed split of hyperv-tlfs.h into arch dependent
>   and independent versions.  In this patch set, update the ARM64
>   hyperv-tlfs.h to include architecture independent definitions.
>   This approach eliminates a lot of lines of otherwise duplicated
>   code on the ARM64 side.
> * Break ARM64 mshyperv.h into smaller pieces. Have an initial
>   baseline, and add code along with patches for a particular
>   functional area. [Marc Zyngier]
> * In mshyperv.h, use static inline functions instead of #defines
>   where possible. [Arnd Bergmann]
> * Use VMbus INTID obtained from ACPI DSDT instead of hardcoding.
>   The STIMER INTID is still hardcoded because it is needed
>   before Linux has initialized the ACPI subsystem, so it can't
>   be obtained from the DSDT.  Wedging it into the GTDT seems
>   dubious, so was not done. [Marc Zyngier]
> * Update Hyper-V page size allocation functions to use
>   alloc_page() if PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE [Arnd
>   Bergmann]
> * Various other minor changes based on feedback and to rebase
>   to latest linux-next [Marc Zyngier and Arnd Bergmann]
>=20
> Changes in v6:
> * Use SMCCC hypercall interface instead of direct invocation
>   of HVC instruction and the Hyper-V hypercall interface
>   [Marc Zyngier]
> * Reimplemented functions to alloc/free Hyper-V size pages
>   using kmalloc/kfree since kmalloc now guarantees alignment of
>   power of 2 size allocations [Marc Zyngier]
> * Export screen_info in arm64 architecture so it can be used
>   by the Hyper-V buffer driver built as a module
> * Renamed source file arch/arm64/hyperv/hv_init.c to hv_core.c
>   to better reflect its content
> * Fixed the bit position of certain feature flags presented by
>   Hyper-V to the guest.  The bit positions on ARM64 don't match
>   the position on x86 like originally thought.
> * Minor fixups to rebase to 5.6-rc5 linux-next
>=20
> Changes in v5:
> * Minor fixups to rebase to 5.4-rc1 linux-next
>=20
> Changes in v4:
> * Moved clock-related code into an architecture independent
>   Hyper-V clocksource driver that is already upstream. Clock
>   related code is removed from this patch set except for the
>   ARM64 specific interrupt handler. [Marc Zyngier]
> * Separately upstreamed the split of mshyperv.h into arch independent
>   and arch dependent portions. The arch independent portion has been
>   removed from this patch set.
> * Divided patch #2 of the series into multiple smaller patches
>   [Marc Zyngier]
> * Changed a dozen or so smaller things based on feedback
>   [Marc Zyngier, Will Deacon]
> * Added functions to alloc/free Hyper-V size pages for use by
>   drivers for Hyper-V synthetic devices when updated to not assume
>   guest page size and Hyper-v page size are the same
>=20
> Changes in v3:
> * Added initialization of hv_vp_index array like was recently
>   added on x86 branch [KY Srinivasan]
> * Changed Hyper-V ARM64 register symbols to be all uppercase
>   instead of mixed case [KY Srinivasan]
> * Separated mshyperv.h into two files, one architecture
>   independent and one architecture dependent. After this code
>   is upstream, will make changes to the x86 code to use the
>   architecture independent file and remove duplication. And
>   once we have a multi-architecture Hyper-V TLFS, will do a
>   separate patch to split hyperv-tlfs.h in the same way.
>   [KY Srinivasan]
> * Minor tweaks to rebase to latest linux-next code
>=20
> Changes in v2:
> * Removed patch to implement slow_virt_to_phys() on ARM64.
>   Use of slow_virt_to_phys() in arch independent Hyper-V
>   drivers has been eliminated by commit 6ba34171bcbd
>   ("Drivers: hv: vmbus: Remove use of slow_virt_to_phys()")
> * Minor tweaks to rebase to latest linux-next code
> *** BLURB HERE ***
>=20
> Michael Kelley (7):
>   smccc: Add HVC call variant with result registers other than 0 thru 3
>   arm64: hyperv: Add Hyper-V hypercall and register access utilities
>   arm64: hyperv: Add Hyper-V clocksource/clockevent support
>   arm64: hyperv: Add kexec and panic handlers
>   arm64: hyperv: Initialize hypervisor on boot
>   arm64: efi: Export screen_info
>   Drivers: hv: Enable Hyper-V code to be built on ARM64
>=20
>  MAINTAINERS                          |   3 +
>  arch/arm64/Kbuild                    |   1 +
>  arch/arm64/hyperv/Makefile           |   2 +
>  arch/arm64/hyperv/hv_core.c          | 178 +++++++++++++++++++++++++++++=
++++++
>  arch/arm64/hyperv/mshyperv.c         | 173 +++++++++++++++++++++++++++++=
+++++
>  arch/arm64/include/asm/hyperv-tlfs.h |  69 ++++++++++++++
>  arch/arm64/include/asm/mshyperv.h    |  72 ++++++++++++++
>  arch/arm64/kernel/efi.c              |   1 +
>  arch/arm64/kernel/setup.c            |   4 +
>  drivers/clocksource/hyperv_timer.c   |  14 +++
>  drivers/hv/Kconfig                   |   3 +-
>  include/linux/arm-smccc.h            |  29 ++++--
>  12 files changed, 542 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm64/hyperv/Makefile
>  create mode 100644 arch/arm64/hyperv/hv_core.c
>  create mode 100644 arch/arm64/hyperv/mshyperv.c
>  create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
>  create mode 100644 arch/arm64/include/asm/mshyperv.h
>=20
> --
> 1.8.3.1

