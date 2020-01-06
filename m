Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB288130CD5
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jan 2020 06:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgAFFCS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Jan 2020 00:02:18 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:7336 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgAFFCR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Jan 2020 00:02:17 -0500
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00651PGO032355;
        Mon, 6 Jan 2020 05:01:59 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 2xb4ahw497-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jan 2020 05:01:59 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 78DF983;
        Mon,  6 Jan 2020 05:01:58 +0000 (UTC)
Received: from hpe.com (ben.americas.hpqcorp.net [10.33.153.7])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 60CDD4C;
        Mon,  6 Jan 2020 05:01:57 +0000 (UTC)
Date:   Sun, 5 Jan 2020 23:01:57 -0600
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
Message-ID: <20200106050157.5htrc4nw7lhixlyy@hpe.com>
Reply-To: Russ Anderson <rja@hpe.com>
References: <CAKv+Gu82ZCk3Wy6NHHyRs0CAFXJDMfDu2KpH3PZ-Le1SjsQLLQ@mail.gmail.com>
 <20191231160547.GB13549@zn.tnic>
 <20200102143757.tqhvff32ksc2rpvh@hpe.com>
 <CAKv+Gu9y9yA+4cnii6QvJ3CjxqmxPmEc333cKezzxwrPCKvKGQ@mail.gmail.com>
 <20200102164536.ks5dmtrbtl4i7rnt@hpe.com>
 <CAKv+Gu86SaU+D8x2ScRXbTvR8aK23CfhAL=mkUNcn=9vrbgznw@mail.gmail.com>
 <20200102231317.yoj2xdplqp42lmcq@hpe.com>
 <CAKv+Gu9VDxWZXKr3nZ1igP-u5q=jo_Z5UPROh+NhkTHdes8CLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9VDxWZXKr3nZ1igP-u5q=jo_Z5UPROh+NhkTHdes8CLA@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_01:2020-01-06,2020-01-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=881 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001060045
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 03, 2020 at 09:14:14AM +0100, Ard Biesheuvel wrote:
> On Fri, 3 Jan 2020 at 00:13, Russ Anderson <rja@hpe.com> wrote:
> > been used to work around issues.
> >
> > One was when KASLR was added (as part of the Spectre/Meldown
> > mitigation).  The initial implementation broke with new
> > map so efi=old_map was used as a workaround.  I don't know
> > if this was a distro specific breakage or upstream, but the
> > workaround limited the impact and the breakage was quickly
> > fixed.
> >
> > Another time was the EFI locking issue mentioned earlier
> > in this thread.
> >
> 
> So are you saying the distros updated their kernels which subsequently
> broke your platforms, and you needed to use efi=old_map in production
> to work around this? This sounds like something that should have been
> caught in testing before the release was made.

The Spectre/Meldown change was rushed through, without proper
testing.  The lesson was that even security fixes need full testing.
All involved (that I am aware of) do not want to repeat releasing
code that has not been fully tested.

The EFI locking issue was caught by the HPE BRT (Basic Regression Test)
team, but after it had been released by distros.  It was a small
timing hole that ALMOST always worked, which is why it was not detected
immediately.

> Is there any way you could make one of these systems
> available/accessible for testing new kernels? Also, was the breakage
> related specifically to the use of the UV runtime services?

HPE does have systems at Red Hat and SUSE (part of the distro test
environments), along with internal test systems.  HPE does have access
to pre-release distro (RHEL, SLES, Oracle Linux) kernels, including
nightly development builds.  I have a kernel engineer on-site at Red Hat
with access to RH kernel engineers and git trees.  We do test upstream
kernels and have fixed regressions.  That said, we do have limited
resources (test systems, people, time) and do as much as we can with
what we have, so it is not perfect.  But we try our best to be perfect.

> > Is there a compelling reason to put efi=old_map quirk
> > under CONFIG_X86_UV=y?  The original patch description assumed
> > only old SGI UV1 used efi=old_map, that it had not been
> > used on newer hardware, but that isn't the case.  It has been
> > used on newer currently shipping hardware.  Given that
> > new information is there a compelling reason for the change?
> 
> Every feature like this doubles the size of the validation matrix, and
> so restricting efi=old_map to a single target helps to keep the
> maintenance effort manageable.

Understood.  

Thanks.
-- 
Russ Anderson,  SuperDome Flex Linux Kernel Group Manager
HPE - Hewlett Packard Enterprise (formerly SGI)  rja@hpe.com
