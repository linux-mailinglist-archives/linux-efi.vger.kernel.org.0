Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177293DDC1A
	for <lists+linux-efi@lfdr.de>; Mon,  2 Aug 2021 17:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbhHBPPr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Aug 2021 11:15:47 -0400
Received: from mail-mw2nam10on2100.outbound.protection.outlook.com ([40.107.94.100]:44898
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233976AbhHBPPp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Aug 2021 11:15:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HN4DCzxm/ztOf7v+VkWrBVBGScRscxH1DgdQ/1QBNAjwJWiaw36GW8umVIRR5ugDs2N9dcXyQZPKVrI5jFbQdB0Wauy/IP9zEa59PwX0LZf97CsfqYiHeHoB3WGkpMlqxJMrEMT1QM5kVXN9o/9JphUOb3Xi/9qgrDExKaTJtKVDhsPUQWILn4B2CVxVVBTjd/ksrvx/65twLYWSbF2zXbFZikD+ZWo2z76DGqmnTXMVy6QhlvkzZlpeu7BAmofD+XKBb6h6NWdtrNwsrGHZUGUxZddt+U7jbnR6y2J4BUnuJQBJ38+MEXKYAcrZ1CwPJZN/5OO6H9eRTuetjr2UQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5HtqGaG7iV8t1IPOTMhnI1Wpsoshhbvl3melCuEOg4=;
 b=SjyoUCWp4qYrIC/Oq+jLad7Rub6sijdzp6ioS5CCqOXcECrGkgBswgWAdRbwo82MPfP28xwqPs33m5lTAbD6l2qy0S0X5Ix0e6gswA3PnT3NidhfhgvQ3ndBq+IxvUxLDtqV6u+ERgU+jwEkwaWZz1VGVVPn4teUuN7KPGt8FA02gB3pzB19hSb/r5if3eX3Ndt/ou1xa0tj2mz6A8g7H8tAfKK1WuRZT4mxQmnN0j2U4HTecGg/gR40N4Awg8Y2nJiMd/zvSPZ+g/e1ddNx9eLqmr4b31IB3wqFR+GbBsmOd9547XVUM87YxuU2aahKY2RchDk4FT+hqeaeKr6oiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5HtqGaG7iV8t1IPOTMhnI1Wpsoshhbvl3melCuEOg4=;
 b=HUaJlcNoZyezpst9yGBt0tffDuTUE+TNOVvD3wHsG5m0EekF+FUG37VY/7F3SVvMJDG/sJygyXhMrWrhphwhFx37L4plEBdMWTl5rLD7tmMtbLqijDyzJDdJP0scNtShANr6eIyZm4GdL3qu1/o6sDEIi8cpOgtBSOxt6oyTLtQ=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB2028.namprd21.prod.outlook.com (2603:10b6:303:11f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.2; Mon, 2 Aug
 2021 15:15:30 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::312e:7352:96f5:6afa]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::312e:7352:96f5:6afa%9]) with mapi id 15.20.4394.008; Mon, 2 Aug 2021
 15:15:30 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
CC:     Mark Rutland <Mark.Rutland@arm.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "ardb@kernel.org" <ardb@kernel.org>
Subject: RE: [PATCH v11 0/5] Enable Linux guests on Hyper-V on ARM64
Thread-Topic: [PATCH v11 0/5] Enable Linux guests on Hyper-V on ARM64
Thread-Index: AQHXfXeMTx/8RLY/KUqunRXQdS2gQ6tgZStA
Date:   Mon, 2 Aug 2021 15:15:30 +0000
Message-ID: <MWHPR21MB1593188EC3D8AD239BF15882D7EF9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1626793023-13830-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1626793023-13830-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c5f51cda-1b7b-472c-ad23-2e48accecae3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-02T15:07:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 173f2643-17e4-476d-e8b7-08d955c85dfb
x-ms-traffictypediagnostic: MW4PR21MB2028:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB2028E7456D51CAA84B2399BDD7EF9@MW4PR21MB2028.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xnfl6gsKlcBZFagq0Kbr+JesFK85kBrl572VVpEv7zVJp2sIMkQutQle68lOumG8FF2vQ5hCNzfKXcoKtkhlIIt1NFy3PRyRt7YqL5VzGEyZHDRxqHBK8s3lcXTIy0tbkvHouaLkfJ9/R57B2XgbLOQ3tFq79MpgQTekKuTTZP6/jIw/J14A4CNqqpJxuQE7uaUFotKGtUhWZPPgR6YMwd1bEhLyau0kbdw1e5C67TovnMXHZ6jh2tMg006NLip3grLN7TllvsQq6fEnX5OzBB3ALQI3WXW5QPEbH+jO3vmURcvrRQMkub/lVeUkh24U3H0lXsAT5CxJyHngNMO+13aB+PaNjgf0YBdto9gGCy9BP01a61wMYkjbuv+sfLKQQy1Ib9qNp7CYsgHQbjEX40Re/zFn+MDIxEWlmmv1LqbdHIyocszYdvguIiIp6pFxj3/LuoYnEUrRiYpkwAtkB+p0nCZugWht5YDwMnzCyBFsrFQSR2lIocplvOa28uFX2f96NIj9NNbXEXW/peU3tXmxRFlkAd6yuoob9wePNUQyl48RLaukqv6MzFngW8o5rGNbUc9sKHEsSocGtofkZgvnXNd2CeQ4We6egODOIb+T01VasLUrux6xBVRqRImb4v9n1Pst2hmcuQgXpeFBsY3m0v2FaVH+P5OeJnmWX22veWe35dr/RmTO/scGc8pe17Q+/kyKoPDjE29oQJl1Uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(6506007)(9686003)(55016002)(8676002)(33656002)(83380400001)(186003)(8936002)(7696005)(26005)(38070700005)(10290500003)(66946007)(508600001)(2906002)(8990500004)(66556008)(38100700002)(66476007)(122000001)(86362001)(316002)(5660300002)(82950400001)(82960400001)(52536014)(110136005)(71200400001)(76116006)(54906003)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z91zJMyft+rFEGSjSArta89l+XjNRC23iCqMxm2TybGIT4zzAxaIuzi3mNfq?=
 =?us-ascii?Q?mKB+qSjS90FJZ/btE33ll8jRaQViS2oJG5b+s68Owuztf6He4x+8Dz0vixw4?=
 =?us-ascii?Q?qxVIy8rh0tLCsC30pILYzaFC5v+RWYI+2PHUuanDuzI1aMA15hyZlRCXvhFY?=
 =?us-ascii?Q?vv9Pq1eOkGV6kAUDZx801jU5QAb4eW9OiOSFj4+HEK331paX0D2/ML6v+vHg?=
 =?us-ascii?Q?0dhqLUvNuXsmMJJ9WPrU8F8ffX62Km/0ozVqFy8pAiKkZjTYLOwCeJEzNqU4?=
 =?us-ascii?Q?FpWs2ejXwUT/CP8C32TXFX5nox0CiJGgyLxbB2Lc1YFtJvOwurxPeFPf1sAi?=
 =?us-ascii?Q?AD+AJkrH1wi1gxb3byxsbMoIyub8f9CSQBzZHc5uuabkMLi9bvfd6tg/1Jo1?=
 =?us-ascii?Q?oGJV9wG4O4u/0eG7wFuJF5q8PLyi2zrp6l7juHutYgdWDgsk6khlgFyGAgIw?=
 =?us-ascii?Q?8/0wEgSEx5SQQ2B/wwno+q4EC6VU95WYBTpQMbLdMWRwXB9YHtDUxAHHGGR+?=
 =?us-ascii?Q?ZymWwzaCjYKKgK1IkAFe8+YckyBQGA6jSrxf+KYzBddRyHb17ebDhULwiFl8?=
 =?us-ascii?Q?mMG4iU+6V5dyTP7GV2vQ/ZhE0pmKJ8sCXfA2hr2wl+6d410knL+WlKG21hB/?=
 =?us-ascii?Q?BmYtPAUtFh7fOUKe836CV2tPCYMJe36sEVs7d29r9wV+kcN4NChiR4+W9Iv+?=
 =?us-ascii?Q?+qwdbB+M4btKam0I/dKDDzsE7VlyWiK48FgcXEJJ5/I1jtZ3Ozc70TdMuWDV?=
 =?us-ascii?Q?j3OQUQYhCNyuvB+r2ZWaztRMxIROpKOLmyj6Q5Asf4Z5x7dOgXJQe4t7ct08?=
 =?us-ascii?Q?LDVQ8QT7iEXVNSkcjETOKYUJGCkJkJY1h0UY0UtN4ub9wmO7Dym9pPYLU49b?=
 =?us-ascii?Q?Cb/BbEvhfb0Mr/3bjJ/Ncy/mkmK7Cdjjw6YcAkPkCBlEnJw9aAmRTIhRmd6a?=
 =?us-ascii?Q?NdEBBQYfukfANSYRxn0lVREz/1xk6e8sd0xY9B6T30ZIqaHxAdngX0SExBTF?=
 =?us-ascii?Q?KziEguYi8MLvXc8iqvMkstElfuoJ2xgSyBn7XUbE4IwNkC3fTNnSxr/IAG97?=
 =?us-ascii?Q?ZwvZ1LZ2boURNH7NAdFiS5NRIrulunQhLHcE6cyBfES6xx42FubCYnsgU3xl?=
 =?us-ascii?Q?6E/CWG/VSrJCLzxQU0iRppchGr8z0qVyvQyAHnYuiiFL0iV2P2+VRnmFOFMs?=
 =?us-ascii?Q?N600mrcRNGhQX2C/M/AiF3cP7bt2k9AnkF+SDCI/pP5X1mRGxLFGnRxJUJV8?=
 =?us-ascii?Q?+DpGSNJoNV0alA274yjUITl5wViP32sO2ISsSlWSixu8XrSazq/N7F5roRK/?=
 =?us-ascii?Q?x+uVwfOZviz2cnhkKG8efeQo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 173f2643-17e4-476d-e8b7-08d955c85dfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2021 15:15:30.6966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZxeAYHNW/ijKXj2+OgSfztBaYzGjo4JyY5rYR/MQXf0RzA8LbIfm+DjLdIhkNJ6DaUY5rwST9tzxRfOTZO7XBbZPC3pTUcLP2IplL0Ec7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2028
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com> Sent: Tuesday, July 20, 2021 =
7:57 AM
>=20
> This series enables Linux guests running on Hyper-V on ARM64
> hardware. New ARM64-specific code in arch/arm64/hyperv initializes
> Hyper-V and its hypercall mechanism.  Existing architecture
> independent drivers for Hyper-V's VMbus and synthetic devices just
> work when built for ARM64. Hyper-V code is built and included in
> the image and modules only if CONFIG_HYPERV is enabled.

Will and Catalin --

Gentle ping. :-)   The clock/timer issues are now worked out in that
Hyper-V is providing full Generic Timer functionality in guest VMs.
That dropped some code out of the patch set, and making additional
code architecture neutral reduced the ARM64 specific code in this patch
set even further. =20

To my knowledge, all issues have been addressed, so I'm looking for
any further review from you as ARM64 maintainers, or your Ack so
this can be ready for the 5.15 merge window.

Thanks!

Michael

>=20
> The five patches are organized as follows:
>=20
> 1) Add definitions and functions for making Hyper-V hypercalls
>    and getting/setting virtual processor registers provided by
>    Hyper-V
>=20
> 2) Add the function needed by the arch independent VMbus driver
>    for reporting a panic to Hyper-V.
>=20
> 3) Add Hyper-V initialization code and utility functions that
>    report Hyper-v status.
>=20
> 4) Export screen_info so it may be used by the Hyper-V frame buffer
>    driver built as a module. It is already exported for x86,
>    powerpc, and alpha architectures.
>=20
> 5) Make CONFIG_HYPERV selectable on ARM64 in addition to x86/x64.
>=20
> Hyper-V on ARM64 runs with a 4 Kbyte page size, but allows guests
> with 4K/16K/64K page size. Linux guests with this patch series
> work with all three supported ARM64 page sizes.
>=20
> The Hyper-V vPCI driver at drivers/pci/host/pci-hyperv.c has
> x86/x64-specific code and is not being built for ARM64. Enabling
> Hyper-V vPCI devices on ARM64 is in progress via a separate set
> of patches.
>=20
> This patch set is based on the linux-next20210720 code tree.
>=20
> Changes in v11:
> * Drop the previous Patch 1 as the fixes have already been
>   separately accepted upstream.
> * Drop the previous Patch 3 for enabling Hyper-V enlightened
>   clocks/timers.  Hyper-V is now offering the full ARM64
>   architectural Generic Timer in guest VMs, so the existing
>   arch_arch_timer.c driver just works. [Mark Rutland, Marc
>   Zyngier]
> * Simplified the previous Patch 4 and Patch 5 (now Patch 2 and 3)
>   by sharing more code between the x86 and ARM64 architectures.
> * Combined hyperv_early_init() and hyperv_init() into a single
>   initialization function that runs as an early_initcall. This
>   is possible because the Hyper-V enlightened clocks/timers
>   no longer need to be initialized early in the boot sequence.
>=20
> Changes in v10:
> * Drop previous Patch 1 for SMCCC v1.2 HVC calls in favor of
>   Sudeep Holla's patch [Mark Rutland]
> * Use new helper functions in 5.13 for checking Hyper-V hypercall
>   return status
> * Set up per-CPU hypercall argument page that is now used by the
>   Hyper-V balloon driver
> * Rebase on 5.13-RC1
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
>=20
> Michael Kelley (5):
>   arm64: hyperv: Add Hyper-V hypercall and register access utilities
>   arm64: hyperv: Add panic handler
>   arm64: hyperv: Initialize hypervisor on boot
>   arm64: efi: Export screen_info
>   Drivers: hv: Enable Hyper-V code to be built on ARM64
>=20
>  MAINTAINERS                          |   3 +
>  arch/arm64/Kbuild                    |   1 +
>  arch/arm64/hyperv/Makefile           |   2 +
>  arch/arm64/hyperv/hv_core.c          | 181 +++++++++++++++++++++++++++++=
++++++
>  arch/arm64/hyperv/mshyperv.c         |  83 ++++++++++++++++
>  arch/arm64/include/asm/hyperv-tlfs.h |  69 +++++++++++++
>  arch/arm64/include/asm/mshyperv.h    |  54 +++++++++++
>  arch/arm64/kernel/efi.c              |   1 +
>  drivers/hv/Kconfig                   |   5 +-
>  9 files changed, 397 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/hyperv/Makefile
>  create mode 100644 arch/arm64/hyperv/hv_core.c
>  create mode 100644 arch/arm64/hyperv/mshyperv.c
>  create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
>  create mode 100644 arch/arm64/include/asm/mshyperv.h
>=20
> --
> 1.8.3.1

