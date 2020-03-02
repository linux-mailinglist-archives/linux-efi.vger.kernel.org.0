Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9E01765D6
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 22:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgCBVVP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Mar 2020 16:21:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726700AbgCBVVP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Mar 2020 16:21:15 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 022LL3Wh080945
        for <linux-efi@vger.kernel.org>; Mon, 2 Mar 2020 16:21:14 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfm51ty4a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Mon, 02 Mar 2020 16:21:14 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 2 Mar 2020 21:21:11 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Mar 2020 21:21:09 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 022LK9AD37880264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Mar 2020 21:20:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FF295204F;
        Mon,  2 Mar 2020 21:21:07 +0000 (GMT)
Received: from osiris (unknown [9.145.25.181])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 0072952059;
        Mon,  2 Mar 2020 21:21:06 +0000 (GMT)
Date:   Mon, 2 Mar 2020 22:21:05 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: add a new CONFIG for loading arch-specific policies
References: <1582744207-25969-1-git-send-email-nayna@linux.ibm.com>
 <1583160524.8544.91.camel@linux.ibm.com>
 <CAKv+Gu_E9O05xB7i2Y8KiMJUjtZoq54GxSbHnyTFePcF6fqQNA@mail.gmail.com>
 <1583161018.8544.96.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1583161018.8544.96.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20030221-0012-0000-0000-0000038C6B98
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030221-0013-0000-0000-000021C91FE8
Message-Id: <20200302212105.GH4035@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_08:2020-03-02,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxscore=0
 clxscore=1011 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=1
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020138
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Mar 02, 2020 at 09:56:58AM -0500, Mimi Zohar wrote:
> On Mon, 2020-03-02 at 15:52 +0100, Ard Biesheuvel wrote:
> > On Mon, 2 Mar 2020 at 15:48, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > > index beea77046f9b..cafa66313fe2 100644
> > > > --- a/arch/x86/Kconfig
> > > > +++ b/arch/x86/Kconfig
> > > > @@ -230,6 +230,7 @@ config X86
> > > >       select VIRT_TO_BUS
> > > >       select X86_FEATURE_NAMES                if PROC_FS
> > > >       select PROC_PID_ARCH_STATUS             if PROC_FS
> > > > +     select IMA_SECURE_AND_OR_TRUSTED_BOOT   if EFI
> > >
> > > Not everyone is interested in enabling IMA or requiring IMA runtime
> > > policies.  With this patch, enabling IMA_ARCH_POLICY is therefore
> > > still left up to the person building the kernel.  As a result, I'm
> > > seeing the following warning, which is kind of cool.
> > >
> > > WARNING: unmet direct dependencies detected for
> > > IMA_SECURE_AND_OR_TRUSTED_BOOT
> > >   Depends on [n]: INTEGRITY [=y] && IMA [=y] && IMA_ARCH_POLICY [=n]
> > >   Selected by [y]:
> > >   - X86 [=y] && EFI [=y]
> > >
> > > Ard, Michael, Martin, just making sure this type of warning is
> > > acceptable before upstreaming this patch.  I would appreciate your
> > > tags.
> > >
> > 
> > Ehm, no, warnings like these are not really acceptable. It means there
> > is an inconsistency in the way the Kconfig dependencies are defined.
> > 
> > Does this help:
> > 
> >   select IMA_SECURE_AND_OR_TRUSTED_BOOT   if EFI && IMA_ARCH_POLICY
> > 
> > ?
> 
> Yes, that's fine for x86.  Michael, Martin, do you want something
> similar or would you prefer actually selecting IMA_ARCH_POLICY?

For s390 something like

	select IMA_SECURE_AND_OR_TRUSTED_BOOT if IMA_ARCH_POLICY

should be fine.

Thanks,
Heiko

