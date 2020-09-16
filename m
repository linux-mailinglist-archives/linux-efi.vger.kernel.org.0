Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE1226C6FB
	for <lists+linux-efi@lfdr.de>; Wed, 16 Sep 2020 20:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgIPSMs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Sep 2020 14:12:48 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:45094 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727846AbgIPSMo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Sep 2020 14:12:44 -0400
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GI8fR2002128;
        Wed, 16 Sep 2020 18:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : content-type : in-reply-to
 : mime-version; s=pps0720;
 bh=r7o24jDeCuqZLlq1UTiJUs06yNxpLvj1FGdfzK7+HFE=;
 b=FjgcyWG+s4lUSDtHPxOWGSiYjnnXsNJFJoJVoWytGu+9FNz+vppZLv287DR33oMm9UuO
 bA+Cmxg6n+TZalESF6OYeqpgCBUVSE21Sz1XVsxY51POd+iH0BzER3aISwoW5liK+pej
 IDUIdfTVEZfhtR5hHkZFCnWWL9htv5KSEgxzOcXWMOIBZbrskBYTb6eFzFb/SQEwHodM
 +8Kt8WobYieXc1JeDWfxdLK8mhzjKruYryW8hKgXPmNaAfbSXbf3v6tCj7jKdGsJN1km
 zpDd/dxoj5c0nUfUFZvKBI8CzxR3yvil5TwlXtP14vYHLS3vRe0y95+4EtqN6s7PE5iM 5A== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 33k5nqaw37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 18:12:28 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id F153C57;
        Wed, 16 Sep 2020 18:12:27 +0000 (UTC)
Received: from hpe.com (ben.americas.hpqcorp.net [10.33.153.7])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 5710F45;
        Wed, 16 Sep 2020 18:12:27 +0000 (UTC)
Date:   Wed, 16 Sep 2020 13:12:27 -0500
From:   Russ Anderson <rja@hpe.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-edac@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mchehab@kernel.org, russ.anderson@hpe.com,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        kluveralex@gmail.com
Subject: Re: [PATCH v2 1/2] edac,ghes,cper: Add Row Extension to Memory Error
 Record
Message-ID: <20200916181155.kdsapz5rdolrnap4@hpe.com>
Reply-To: Russ Anderson <rja@hpe.com>
References: <20200819143544.155096-1-alex.kluver@hpe.com>
 <20200819143544.155096-2-alex.kluver@hpe.com>
 <20200915163312.GO14436@zn.tnic>
 <CAMj1kXHmVhB88qZc-1mHAD1ovNJQnWRBncmQJTR_4+kV0fXG5w@mail.gmail.com>
 <CAMj1kXGvfiqZz-j5=LU0Z6yYCkr24pCz6aJS62QL8cBYUP_S=w@mail.gmail.com>
 <20200915171910.GQ14436@zn.tnic>
 <CAMj1kXE6PKb==h_154hRKwZLr3Ek+4z4A8FdTHx=co18ww5d3Q@mail.gmail.com>
 <20200916181030.GR2643@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916181030.GR2643@zn.tnic>
User-Agent: NeoMutt/20170421 (1.8.2)
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_11:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160129
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 16, 2020 at 08:10:30PM +0200, Borislav Petkov wrote:
> On Wed, Sep 16, 2020 at 04:09:36PM +0300, Ard Biesheuvel wrote:
> > git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> 
> Looks good and no conflicts, builds fine too.

Excellent.
Thanks!

> [boris@zn: ~/kernel/linux> git fetch efi
> remote: Enumerating objects: 85, done.
> remote: Counting objects: 100% (85/85), done.
> remote: Compressing objects: 100% (14/14), done.
> remote: Total 131 (delta 71), reused 85 (delta 71), pack-reused 46
> Receiving objects: 100% (131/131), 113.14 KiB | 1.69 MiB/s, done.
> Resolving deltas: 100% (89/89), completed with 33 local objects.
> From git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi
>  + 84780c5438ef...744de4180a43 next                    -> efi/next  (forced update)
>    fb1201aececc..46908326c6b8  urgent                  -> efi/urgent
>  * [new tag]                   efi-next-for-v5.10      -> efi-next-for-v5.10
>  * [new tag]                   efi-urgent-for-v5.9-rc5 -> efi-urgent-for-v5.9-rc5
>  * [new tag]                   efi-riscv-shared-for-v5.10 -> efi-riscv-shared-for-v5.10
> [boris@zn: ~/kernel/linux> git checkout -b test-merge ras/edac-for-next
> Branch 'test-merge' set up to track remote branch 'edac-for-next' from 'ras'.
> Switched to a new branch 'test-merge'
> [boris@zn: ~/kernel/linux> git merge efi/next
> Auto-merging drivers/firmware/efi/libstub/efi-stub-helper.c
> Auto-merging drivers/firmware/efi/efi.c
> Auto-merging drivers/edac/ghes_edac.c
> Auto-merging arch/x86/platform/efi/efi.c
> Merge made by the 'recursive' strategy.
>  arch/arm/include/asm/efi.h                      |  23 +++--
>  arch/arm64/include/asm/efi.h                    |   5 +-
>  arch/x86/kernel/setup.c                         |   1 +
>  arch/x86/platform/efi/efi.c                     |   3 +
>  drivers/edac/ghes_edac.c                        |  17 +++-
>  drivers/firmware/efi/Makefile                   |   3 +-
>  drivers/firmware/efi/cper.c                     |  18 +++-
>  drivers/firmware/efi/{arm-init.c => efi-init.c} |   1 +
>  drivers/firmware/efi/efi.c                      |   6 ++
>  drivers/firmware/efi/libstub/arm32-stub.c       | 178 +++++++---------------------------
>  drivers/firmware/efi/libstub/arm64-stub.c       |   1 -
>  drivers/firmware/efi/libstub/efi-stub-helper.c  | 101 +++++++++++++++++++-
>  drivers/firmware/efi/libstub/efi-stub.c         |  48 +---------
>  drivers/firmware/efi/libstub/efistub.h          |  61 +++++++++++-
>  drivers/firmware/efi/libstub/file.c             |   5 +-
>  drivers/firmware/efi/libstub/relocate.c         |   4 +-
>  drivers/firmware/efi/libstub/vsprintf.c         |   2 +-
>  drivers/firmware/efi/mokvar-table.c             | 360 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/cper.h                            |  24 ++++-
>  include/linux/efi.h                             |  34 +++++++
>  include/linux/pe.h                              |   3 +
>  security/integrity/platform_certs/load_uefi.c   |  85 +++++++++++++----
>  22 files changed, 746 insertions(+), 237 deletions(-)
>  rename drivers/firmware/efi/{arm-init.c => efi-init.c} (99%)
>  create mode 100644 drivers/firmware/efi/mokvar-table.c
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
Russ Anderson,  SuperDome Flex Linux Kernel Group Manager
HPE - Hewlett Packard Enterprise (formerly SGI)  rja@hpe.com
