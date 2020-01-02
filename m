Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF75F12F1B0
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2020 00:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgABXNa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 18:13:30 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:42904 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726019AbgABXNa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 18:13:30 -0500
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 002NCaFf032328;
        Thu, 2 Jan 2020 23:13:19 GMT
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2x9qw2gn8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jan 2020 23:13:19 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id 2D9E758;
        Thu,  2 Jan 2020 23:13:18 +0000 (UTC)
Received: from hpe.com (ben.americas.hpqcorp.net [10.33.153.7])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 930A245;
        Thu,  2 Jan 2020 23:13:17 +0000 (UTC)
Date:   Thu, 2 Jan 2020 17:13:17 -0600
From:   Russ Anderson <rja@hpe.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dave Young <dyoung@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>
Subject: Re: [RFC PATCH] efi/x86: limit EFI old memory map to SGI UV1 machines
Message-ID: <20200102231317.yoj2xdplqp42lmcq@hpe.com>
Reply-To: Russ Anderson <rja@hpe.com>
References: <CAKv+Gu82ZCk3Wy6NHHyRs0CAFXJDMfDu2KpH3PZ-Le1SjsQLLQ@mail.gmail.com>
 <20191231160547.GB13549@zn.tnic>
 <20200102143757.tqhvff32ksc2rpvh@hpe.com>
 <CAKv+Gu9y9yA+4cnii6QvJ3CjxqmxPmEc333cKezzxwrPCKvKGQ@mail.gmail.com>
 <20200102164536.ks5dmtrbtl4i7rnt@hpe.com>
 <CAKv+Gu86SaU+D8x2ScRXbTvR8aK23CfhAL=mkUNcn=9vrbgznw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu86SaU+D8x2ScRXbTvR8aK23CfhAL=mkUNcn=9vrbgznw@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-02_08:2020-01-02,2020-01-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001020184
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 02, 2020 at 05:52:39PM +0100, Ard Biesheuvel wrote:
> On Thu, 2 Jan 2020 at 17:45, Russ Anderson <rja@hpe.com> wrote:
> >
> > I want to make sure my undestanding of what you are proposing
> > is the same as what you are proposing.
> >
> 
> What I am proposing is to document efi=old_map as only being available
> on kernels built with CONFIG_X86_UV=y, and moving the code that
> implements it into the UV support code.
> 
> > I will have some additional background information shortly.
> >
> 
> Thanks, that is very helpful.

After talking with some engineers, here is a brief history.

When EFI new mapping was implemented, it did not work with
the SGI UV1 bios, which worked with the old EFI mapping.
Boris added the efi=old_map quirk as a workaround to keep
UV1 working.

SGI UV2 bios (and later) have a fix for that issue, so the
quirk was modified for just UV1 by this commit.  That allowed
new EFI mapping to be used on newer UV platforms.

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/x86/platform/efi/quirks.c?id=d394f2d9d8e1e7b4959819344baf67b5995da9b0

There have been at least two other times efi=old_map has
been used to work around issues.

One was when KASLR was added (as part of the Spectre/Meldown
mitigation).  The initial implementation broke with new
map so efi=old_map was used as a workaround.  I don't know
if this was a distro specific breakage or upstream, but the
workaround limited the impact and the breakage was quickly
fixed.

Another time was the EFI locking issue mentioned earlier
in this thread.

Those are a couple of examples of efi=old_map being used
after the UV1 platform.  They were cases of issues that
impacted the new EFI mapping, not platform or bios issues,
and having the ability to fall back to the old EFI mapping
helped minimize the impact.  Neither were problems in the
new EFI mapping code itself, with the new mapping an
innocent victim of other issues.

Having the efi=old_map quirk available with CONFIG_X86_UV=y
makes it available on the platform I care about, and as it
is enabled in the distros we support (SLES, RHEL, Oracle Linux)
and Fedora.  Not sure if anyone else has used efi=old_map to
work around other issues, but this change would remove
old_map as a possible workaround for others.

Is there a compelling reason to put efi=old_map quirk
under CONFIG_X86_UV=y?  The original patch description assumed
only old SGI UV1 used efi=old_map, that it had not been
used on newer hardware, but that isn't the case.  It has been
used on newer currently shipping hardware.  Given that
new information is there a compelling reason for the change?

Thanks.

-- 
Russ Anderson,  SuperDome Flex Linux Kernel Group Manager
HPE - Hewlett Packard Enterprise (formerly SGI)  rja@hpe.com
