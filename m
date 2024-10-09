Return-Path: <linux-efi+bounces-1932-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE09399713F
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2024 18:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994292822E1
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2024 16:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AA21F4FAC;
	Wed,  9 Oct 2024 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjIZXS1Z"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA351F12E0;
	Wed,  9 Oct 2024 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490436; cv=none; b=ZS+WLWgzn+zlAazOTP0HBHEcjWZjQU1uNUNDgrwJv2XmrgoWgXk8DJmjtKGNl62sK7jrZeYCrktUaX5WZhUXXUJoZMwA4XuUNU0NBFT4U4li5D0OjSBdRgi3pZOOjm8ZNPW888TE80WbwzizzHjSFEanUZY1RCC7pwJ4yt48qIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490436; c=relaxed/simple;
	bh=J3jqmjw+LkkGkYhifldDnZp/qywAKEQbYkNuie5QGac=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XJOPUjKtrdRe0ZVxWwhnEkkPCEYLMrhrsnDgZoKsaNHtCK4kavx2DowjIyOzQ0YgoPQn3QVm1xetYC+R3VO0ZkZcXufD0LW//sH/0z1DNJT8faWgosCcgDUDqEMxKtA61nVx5PWH4Vy8bLjQNAqnaXPX3bnfqiqva6idsUmSM/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjIZXS1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB15DC4CEC3;
	Wed,  9 Oct 2024 16:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728490436;
	bh=J3jqmjw+LkkGkYhifldDnZp/qywAKEQbYkNuie5QGac=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=XjIZXS1ZO6S05rHuv1CGMNLgeEQLy8LXzwY3CEIzXbjYLUFiyLrIrN+U3O91gkVlo
	 FlvpY2QAOeiujo2fkDFx8Rd3AdnYChpbRVmU3zOzVA/y7w9COQ/tvVkF5dQBIDOELB
	 YSqPAcX5/f+/uk+k+054rjuZP2DwIwM8fto8Nj1FmV22tCKW5J6aiEdgsZAVKCw7M2
	 crRQlOL+NnJhVRcAYpfvBLyAvLTP/R9lV4MnzFx2RD62Vgqxj4D0wK36lQoONwsymn
	 W5WA0inD2kfg3AlNpuWy16/wSrmH7S97rcK0l/aFCX6qJTpz8f1U6gG3eBxK2Yqwom
	 jEXZ5/hJFQfPw==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Oct 2024 19:13:52 +0300
Message-Id: <D4REPYHQ15AZ.2042JQR9W9MYY@kernel.org>
Cc: "Breno Leitao" <leitao@debian.org>, <noodles@earth.li>, "Gregory Price"
 <gourry@gourry.net>, <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <arnd@arndb.de>,
 "Ard Biesheuvel" <ardb@kernel.org>, <tweek@google.com>,
 <leendert@watson.ibm.com>, <kjhall@us.ibm.com>
Subject: Re: Possible overflow of TPM log
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Usama Arif" <usamaarif642@gmail.com>,
 <linux-integrity@vger.kernel.org>, <tpmdd-devel@lists.sourceforge.net>,
 <devel@edk2.groups.io>, <linux-efi@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <c4da3a99-2e9d-4461-a429-f07a7deaf8f1@gmail.com>
In-Reply-To: <c4da3a99-2e9d-4461-a429-f07a7deaf8f1@gmail.com>

On Wed Oct 9, 2024 at 6:29 PM EEST, Usama Arif wrote:
> Hi,
>
> We (meta) are seeing the below warning in production machines for all ker=
nels from 5.12 to 6.11 during boot which results in tpm probe failing:
>
>
> [    6.388599] ------------[ cut here ]------------                      =
                                                                           =
                                                                           =
                                                                           =
                  =20
> [    6.397804] memremap attempted on mixed range 0x000000005f54e018 size:=
 0x23ba3cfb                                                                =
                                                                           =
                                                                           =
                  =20
> [    6.412733] WARNING: CPU: 2 PID: 1 at kernel/iomem.c:82 memremap+0x58/=
0x1b0                                                                      =
                                                                           =
                                                                           =
                  =20
> [    6.426621] Modules linked in:                                        =
                                                                           =
                                                                           =
                                                                           =
                  =20
> [    6.432705] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 6.4.3-0_fbk12_26=
24_g7d95a0297d81 #1                                                        =
                                                                           =
                                                                           =
                  =20
> [    6.449020] Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP,=
 BIOS F09_3A23 12/08/2020                                                  =
                                                                           =
                                                                           =
                  =20
> [    6.466377] RIP: 0010:memremap+0x58/0x1b0                             =
                                                                           =
                                                                           =
                                                                           =
                  =20
> [    6.474369] Code: 41 89 c4 83 f8 02 75 26 80 3d fc 33 66 01 00 75 57 c=
6 05 f3 33 66 01 01 48 89 e6 48 c7 c7 3b 98 34 82 4c 89 f2 e8 38 96 bc ff <=
0f> 0b eb 3a 41 f6 c7 01 75 04 31 db eb 13 45 85 e4 74 69 48 89 ef         =
                                                                           =
                  =20
> [    6.511837] RSP: 0000:ffffc900000378f8 EFLAGS: 00010286               =
                                                                           =
                                                                           =
                                                                           =
                  =20
> [    6.522258] RAX: 0000000000000045 RBX: 0000000000000000 RCX: ffffffff8=
2c5fdb8                                                                    =
                                                                           =
                                                                           =
                  =20
> [    6.536490] RDX: 0000000000000000 RSI: c0000000fffeffff RDI: 000000000=
000ffff                                                                    =
                                                                           =
                                                                           =
                  =20
> [    6.550723] RBP: 000000005f54e018 R08: ffffffff82de0190 R09: 000000000=
0000000                                                                    =
                                                                           =
                                                                           =
                  =20
> [    6.564956] R10: ffffffff82c5fde0 R11: 3fffffffffffffff R12: 000000000=
0000002                                                                    =
                                                                           =
                                                                           =
                  =20
> [    6.579187] R13: 0000000000000000 R14: 0000000023ba3cfb R15: 000000000=
0000001                                                                    =
                                                                           =
                                                                           =
                  =20
> [    6.593421] FS:  0000000000000000(0000) GS:ffff88903f880000(0000) knlG=
S:0000000000000000                                                         =
                                                                           =
                                                                           =
                  =20
> [    6.609559] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033         =
                                                                           =
                                                                           =
                                                                           =
                  =20
> [    6.621026] CR2: 0000000000000000 CR3: 0000000062c0a001 CR4: 000000000=
07706e0                                                                    =
                                                                           =
                                                                           =
                  =20
> [    6.635257] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000                                                                    =
                                                                           =
                                                                           =
                  =20
> [    6.649489] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400                                                                    =
                                                                           =
                                                                           =
                  =20
> [    6.663724] PKRU: 55555554                                            =
                                                                           =
                                                                           =
                                                                           =
                  =20
> [    6.669115] Call Trace:                                               =
     =20
> [    6.673986]  <TASK>                                                   =
     =20
> [    6.678162]  ? __warn+0x9f/0x130                                      =
     =20
> [    6.684595]  ? memremap+0x58/0x1b0                                    =
     =20
> [    6.691371]  ? report_bug+0xcc/0x150                                  =
     =20
> [    6.698499]  ? handle_bug+0x3d/0x70                                   =
     =20
> [    6.705449]  ? exc_invalid_op+0x16/0x40                               =
     =20
> [    6.713093]  ? asm_exc_invalid_op+0x16/0x20                           =
     =20
> [    6.721433]  ? memremap+0x58/0x1b0                                    =
     =20
> [    6.728211]  ? memremap+0x58/0x1b0                                    =
     =20
> [    6.732866] Freeing initrd memory: 51140K                             =
     =20
> [    6.734986]  tpm_read_log_efi+0x7d/0x1e0                              =
     =20
> [    6.750795]  tpm_bios_log_setup+0x51/0x170                            =
     =20
> [    6.758959]  tpm_chip_register+0x36/0x220                             =
     =20
> [    6.766948]  tpm_tis_core_init+0x438/0x630                            =
     =20
> [    6.775112]  tpm_tis_init+0x103/0x190                                 =
     =20
> [    6.782410]  tpm_tis_plat_probe+0x87/0x90                             =
     =20
> [    6.790401]  platform_probe+0x2f/0x60                                 =
     =20
> [    6.797705]  really_probe+0x1ec/0x340                                 =
     =20
> [    6.805002]  driver_probe_device+0x1e/0x80                            =
     =20
> [    6.813184]  __driver_attach+0x10e/0x1a0                              =
     =20
> [    6.821018]  ? driver_attach+0x20/0x20                                =
     =20
> [    6.828491]  bus_for_each_dev+0x64/0xa0                               =
     =20
> [    6.836136]  bus_add_driver+0x196/0x210                               =
     =20
> [    6.843781]  ? __initstub__kmod_tpm__370_527_tpm_init4+0x100/0x100    =
                                                                           =
         =20
> [    6.856109]  driver_register+0x5e/0xf0                                =
     =20
> [    6.863580]  __initstub__kmod_tpm_tis__319_478_init_tis6+0x7f/0xc0    =
                                                                           =
         =20
> [    6.875908]  ? add_device_randomness+0x62/0x70                        =
     =20
> [    6.884768]  do_one_initcall+0xad/0x1f0                               =
     =20
> [    6.892414]  ? alloc_pages+0x120/0x2c0                                =
     =20
> [    6.899885]  ? security_kernfs_init_security+0x2a/0x40                =
     =20
> [    6.910132]  ? idr_alloc_cyclic+0xaa/0x110                            =
     =20
> [    6.918295]  ? idr_alloc_cyclic+0xaa/0x110                            =
     =20
> [    6.926458]  ? alloc_pages+0x15c/0x2c0                                =
     =20
> [    6.933928]  ? number+0x1da/0x400                                     =
     =20
> [    6.940531]  ? ida_alloc_range+0x193/0x410                            =
     =20
> [    6.948696]  ? parse_args+0x14b/0x380                                 =
     =20
> [    6.955996]  kernel_init_freeable+0x1b1/0x2a0                         =
     =20
> [    6.964682]  ? rest_init+0xb0/0xb0                                    =
     =20
> [    6.971461]  kernel_init+0x16/0x1a0                                   =
     =20
> [    6.978410]  ret_from_fork+0x1f/0x30                                  =
     =20
> [    6.985536]  </TASK>                                                  =
     =20
> [    6.989885] ---[ end trace 0000000000000000 ]---                      =
     =20
> [    6.999089] Could not map UEFI TPM log table payload!  =20
>
>
> The memremap being attempted is from 0x5f54e018 to 0x830f1d13, which look=
ing at /proc/iomem, is overlapping all the below regions.
>
> cat /proc/iomem
> ...
>   61000000-61ffffff : Kernel code
>   62000000-62bf4fff : Kernel rodata
>   62c00000-634e28bf : Kernel data
>   63b8e000-641fffff : Kernel bss
> 64dbb000-64dbbfff : Reserved
> 64dbc000-69c89fff : System RAM
> 69c8a000-6bd89fff : Reserved
>   6ad6d018-6ad6d027 : APEI EINJ
>   6ad6d048-6ad6d067 : APEI EINJ
>   6ad6d078-6ad6d07f : APEI EINJ
>   6ad6e018-6ad6e018 : APEI ERST
>   6ad6e01c-6ad6e021 : APEI ERST
>   6ad6e028-6ad6e039 : APEI ERST
>   6ad6e040-6ad6e04c : APEI ERST
>   6ad6e050-6ad7004f : APEI ERST
> 6bd8a000-6be44fff : ACPI Tables
> 6be45000-6c99efff : ACPI Non-volatile Storage
> 6c99f000-6ebedfff : Reserved
> 6ebee000-6fffffff : System RAM
> 70000000-7fffffff : Reserved
> 80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
> ...
>
> The kernel is being booted using kexec. 0x23ba3cfb is 571MB which looks t=
oo big. Could it be that the log size grew too big in the previous kernel? =
Or is it a memory corruption similar to the issue we encountered in [1] and=
 solved in [2]?
>
> [1] https://lore.kernel.org/all/20240910-juicy-festive-sambar-9ad23a@devv=
m32600/
> [2] https://lore.kernel.org/all/20240912155159.1951792-2-ardb+git@google.=
com/

I'd look at it if I had extra bandwidth but I hope someone who knows
better kexec/EFI will take this earliest time I have time to investigate
is like few weeks from now because I started on new jobs.

So right now for few only strictly TPM focused bugs. Just implying
my situation. In a normal situation I'd actually find this quite
interesting. I'll check where it is after some weeks.

>
> Thanks!
> Usama


BR, Jarkko

