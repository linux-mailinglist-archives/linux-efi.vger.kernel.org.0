Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD9E2662F3
	for <lists+linux-efi@lfdr.de>; Fri, 11 Sep 2020 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgIKQHh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Sep 2020 12:07:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726546AbgIKQFY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Sep 2020 12:05:24 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BG3rwa141691;
        Fri, 11 Sep 2020 12:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=YJcSNsfJmDfN2POnRfQ8iV1tWua9L62iukE8JEYPFwM=;
 b=JiTOlVd9zXNwEJsSPw2KmFeHYudqDBBgeAx9zpaTeT2w9G9+Ap9x8GYuUjJPcqpIF0Op
 hxCl5JxpzC5pnSbWBTcrngV2LIMzZqO6kILYC7yZ/buQkCXf6+IYAnerrE/ulau9AiV/
 aUTUztHAy/1iZ9SzfC+nCkSIYdklIuIOcWZIOrUjmaqI4HQOWqG53U6FUpDGVUofJVGc
 DbvKEUhc3CqqWvtXg+B8AK46Iz8+QK86EjyzU+1uhV6JvwU2IuotdlSyV5NAOumMcDP6
 VTxe27KdfkbH4oVFB64RCBxTFHnNwHZnvC3+agEpjvrESaI3Ec2gNJJHiTBhffuQW2K7 Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33gc3p0h0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 12:05:17 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08BG5GA4149160;
        Fri, 11 Sep 2020 12:05:16 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33gc3p0ehj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 12:05:16 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BFwUJw015347;
        Fri, 11 Sep 2020 16:01:17 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 33f91w924c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 16:01:17 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08BG1FGH35914100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 16:01:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 251DA4204C;
        Fri, 11 Sep 2020 16:01:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81DA442042;
        Fri, 11 Sep 2020 16:01:12 +0000 (GMT)
Received: from sig-9-65-251-51.ibm.com (unknown [9.65.251.51])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Sep 2020 16:01:12 +0000 (GMT)
Message-ID: <434085a28e9291dd799c1adbf08f003b7e5eb53d.camel@linux.ibm.com>
Subject: Re: [PATCH V2 0/3] integrity: Load certs from EFI MOK config table
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Lenny Szubowicz <lszubowi@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, andy.shevchenko@gmail.com,
        James Morris <jmorris@namei.org>, serge@hallyn.com,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Jones <pjones@redhat.com>,
        David Howells <dhowells@redhat.com>, prarit@redhat.com
Date:   Fri, 11 Sep 2020 12:01:11 -0400
In-Reply-To: <CAMj1kXHOcGiwOT_sNTQRA=G7GCQSKLk2HSNoS2vEQYPzQpn0nw@mail.gmail.com>
References: <20200905013107.10457-1-lszubowi@redhat.com>
         <CAMj1kXHOcGiwOT_sNTQRA=G7GCQSKLk2HSNoS2vEQYPzQpn0nw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_08:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110127
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2020-09-11 at 18:17 +0300, Ard Biesheuvel wrote:
> On Sat, 5 Sep 2020 at 04:31, Lenny Szubowicz <lszubowi@redhat.com> wrote:
> >
> > Because of system-specific EFI firmware limitations, EFI volatile
> > variables may not be capable of holding the required contents of
> > the Machine Owner Key (MOK) certificate store when the certificate
> > list grows above some size. Therefore, an EFI boot loader may pass
> > the MOK certs via a EFI configuration table created specifically for
> > this purpose to avoid this firmware limitation.
> >
> > An EFI configuration table is a simpler and more robust mechanism
> > compared to EFI variables and is well suited for one-way passage
> > of static information from a pre-OS environment to the kernel.
> >
> > Entries in the MOK variable configuration table are named key/value
> > pairs. Therefore the shim boot loader can create a MokListRT named
> > entry in the MOK configuration table that contains exactly the same
> > data as the MokListRT UEFI variable does or would otherwise contain.
> > As such, the kernel can load certs from the data in the MokListRT
> > configuration table entry data in the same way that it loads certs
> > from the data returned by the EFI GetVariable() runtime call for the
> > MokListRT variable.
> >
> > This patch set does not remove the support for loading certs from the
> > EFI MOK variables into the platform key ring. However, if both the EFI
> > MOK configuration table and corresponding EFI MOK variables are present,
> > the MOK table is used as the source of MOK certs.
> >
> > The contents of the individual named MOK config table entries are
> > made available to user space as individual sysfs binary files,
> > which are read-only to root, under:
> >
> >         /sys/firmware/efi/mok-variables/
> >
> > This enables an updated mokutil to provide support for:
> >
> >         mokutil --list-enrolled
> >
> > such that it can provide accurate information regardless of whether
> > the MOK configuration table or MOK EFI variables were the source
> > for certs. Note that all modifications of MOK related state are still
> > initiated by mokutil via EFI variables.
> >
> > V2: Incorporate feedback from V1
> >   Patch 01: efi: Support for MOK variable config table
> >   - Minor update to change log; no code changes
> >   Patch 02: integrity: Move import of MokListRT certs to a separate routine
> >   - Clean up code flow in code moved to load_moklist_certs()
> >   - Remove some unnecessary initialization of variables
> >   Patch 03: integrity: Load certs from the EFI MOK config table
> >   - Update required due to changes in patch 02.
> >   - Remove unnecessary init of mokvar_entry in load_moklist_certs()
> >
> > V1:
> >   https://lore.kernel.org/lkml/20200826034455.28707-1-lszubowi@redhat.com/
> >
> > Lenny Szubowicz (3):
> >   efi: Support for MOK variable config table
> >   integrity: Move import of MokListRT certs to a separate routine
> >   integrity: Load certs from the EFI MOK config table
> >
> >  arch/x86/kernel/setup.c                       |   1 +
> >  arch/x86/platform/efi/efi.c                   |   3 +
> >  drivers/firmware/efi/Makefile                 |   1 +
> >  drivers/firmware/efi/arm-init.c               |   1 +
> >  drivers/firmware/efi/efi.c                    |   6 +
> >  drivers/firmware/efi/mokvar-table.c           | 360 ++++++++++++++++++
> >  include/linux/efi.h                           |  34 ++
> >  security/integrity/platform_certs/load_uefi.c |  85 ++++-
> >  8 files changed, 472 insertions(+), 19 deletions(-)
> >  create mode 100644 drivers/firmware/efi/mokvar-table.c
> >
> 
> Thanks. I have tentatively queued these up in efi/next.
> 
> Mimi, please let me know if you have any thoughts on 3/3, and whether
> your R-b on 2/3 [v1] implies that you are ok with the series going
> through the EFI tree.

Yes, Ard, that was the intent.  I haven't reviewed the most recent
version.

Mimi

