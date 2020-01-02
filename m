Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E47C612E8DA
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 17:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgABQpz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 11:45:55 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:14450 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728280AbgABQpy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 11:45:54 -0500
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 002Gb4xf027654;
        Thu, 2 Jan 2020 16:45:38 GMT
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2x9g07skgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jan 2020 16:45:38 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id 4502D5B;
        Thu,  2 Jan 2020 16:45:37 +0000 (UTC)
Received: from hpe.com (ben.americas.hpqcorp.net [10.33.153.7])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id AF9E245;
        Thu,  2 Jan 2020 16:45:36 +0000 (UTC)
Date:   Thu, 2 Jan 2020 10:45:36 -0600
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
Message-ID: <20200102164536.ks5dmtrbtl4i7rnt@hpe.com>
Reply-To: Russ Anderson <rja@hpe.com>
References: <CAKv+Gu82ZCk3Wy6NHHyRs0CAFXJDMfDu2KpH3PZ-Le1SjsQLLQ@mail.gmail.com>
 <20191231160547.GB13549@zn.tnic>
 <20200102143757.tqhvff32ksc2rpvh@hpe.com>
 <CAKv+Gu9y9yA+4cnii6QvJ3CjxqmxPmEc333cKezzxwrPCKvKGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9y9yA+4cnii6QvJ3CjxqmxPmEc333cKezzxwrPCKvKGQ@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-02_05:2020-01-02,2020-01-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 suspectscore=2 bulkscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001020144
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 02, 2020 at 04:04:39PM +0100, Ard Biesheuvel wrote:
> On Thu, 2 Jan 2020 at 15:38, Russ Anderson <rja@hpe.com> wrote:
> >
> > On Tue, Dec 31, 2019 at 05:05:47PM +0100, Borislav Petkov wrote:
> > > On Tue, Dec 31, 2019 at 12:13:18PM +0100, Ard Biesheuvel wrote:
> > > > (adding Boris and Dave for the historical perspective)
> > > >
> > > > On Thu, 26 Dec 2019 at 10:55, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > We carry a quirk in the x86 EFI code to switch back to an older
> > > > > method of mapping the EFI runtime services memory regions, because
> > > > > it was deemed risky at the time to implement a new method without
> > > > > providing a fallback to the old method in case problems arose.
> > > > >
> > > > > Such problems did arise, but they appear to be limited to SGI UV1
> > > > > machines, and so these are the only ones for which the fallback gets
> > > > > enabled automatically (via a DMI quirk). The fallback can be enabled
> > > > > manually as well, by passing efi=old_map, but there is very little
> > > > > evidence that suggests that this is something that is being relied
> > > > > upon in the field.
> > > > >
> > > > > Given that UV1 support is not enabled by default by the distros
> > > > > (Ubuntu, Fedora), there is no point in carrying this fallback code
> > > > > all the time if there are no other users. So let's refactor it a bit
> > > > > to make it depend on CONFIG_X86_UV, and remove the ability to enable
> > > > > it by hand.
> > > > >
> > > > > Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> > > > > Cc: Mike Travis <mike.travis@hpe.com>
> > > > > Cc: Hedi Berriche <hedi.berriche@hpe.com>
> > > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > >
> > > > Boris, since you were the one that added efi=old_map: do you know of
> > > > any cases beyond SGI UV1 where it was actually needed? There is some
> > > > mention of using it to work around transient breakage on 32-bit caused
> > > > by your original changes, but other than that, Google doesn't seem to
> > > > know about any cases where efi=old_map is being used to deal with
> > > > actual firmware quirks.
> >
> > We (SGI -> HPE) have used the efi=old_map quirk to work around issues,
> > including on the currently shipping HPE Superdome Flex (aka UV4).
> >
> > An example was working around an EFI locking issues when calling
> > into BIOS, fixed by this commit.
> >
> >   f331e766c4be ("x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls")
> >
> > We do not currently use the quirk, and nopefully never will need to
> > use it again, but it has been used recently and are very glad Boris
> > added it.  I am hesitent to remove it because it has been used recently
> > on currently shipping hardware.
> >
> 
> Thanks for the data point.
> 
> So what about making it depend on CONFIG_X86_UV=y, would that still
> work for you?

I want to make sure my undestanding of what you are proposing
is the same as what you are proposing.

I will have some additional background information shortly.

Thanks.
-- 
Russ Anderson,  SuperDome Flex Linux Kernel Group Manager
HPE - Hewlett Packard Enterprise (formerly SGI)  rja@hpe.com
