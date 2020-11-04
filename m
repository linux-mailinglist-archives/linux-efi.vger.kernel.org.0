Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652E92A6D6B
	for <lists+linux-efi@lfdr.de>; Wed,  4 Nov 2020 20:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgKDTE2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Nov 2020 14:04:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729386AbgKDTD6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Nov 2020 14:03:58 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A4J2d5r065487;
        Wed, 4 Nov 2020 14:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=yOxE0JtfLADlvR2nLuOr0EeZD60hbYIQnY+lcJ2jUzA=;
 b=USck3GLwRc8AlRuEWhy1JAgHDkfhuARablK0JXB37my1GLw05VSGmN5YRifL4gFfa1JC
 RJRIYiv//K8OqAXOJOQfn0tUK93cEIMftQr0Ar2AQjWv5UPgKuXTcleBY2fFmQ3fwhLa
 jPuNId4jC5K1cfaV2vsJQBB9hvhvC7os4DGSEr2EWO04pJVK3oAGJ+F0/FKvBJY84rM3
 AiW+r6w1QnZ9je8JnI0/JurEBS+XqPlwugxbZYE/694cjck42JtBzAqSC+cjrujj0WSS
 NTLL62A0xpZDldoi2JQHDlxVfH8LqHJuOsOyMVyjtQMkJhJ3nosz4+BH4pEXSLd0Yk5p DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34kqdb75jh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 14:03:36 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A4J2d25065467;
        Wed, 4 Nov 2020 14:03:35 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34kqdb75gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 14:03:35 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A4Iv8Zs011155;
        Wed, 4 Nov 2020 19:03:33 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 34h0fcvmy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 19:03:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A4J3UX959965898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Nov 2020 19:03:30 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1300A405F;
        Wed,  4 Nov 2020 19:03:30 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C91BA4054;
        Wed,  4 Nov 2020 19:03:28 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.13.183])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Nov 2020 19:03:28 +0000 (GMT)
Message-ID: <c044fc25be309e7b25a4c64845fd753515c84804.camel@linux.ibm.com>
Subject: Re: [PATCH v4 0/3] wire up IMA secure boot for arm64
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Chester Lin <clin@suse.com>,
        X86 ML <x86@kernel.org>, "Lee, Chun-Yi" <jlee@suse.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 04 Nov 2020 14:03:27 -0500
In-Reply-To: <CAMj1kXEjKt0F8dZBnF=x2ShkxyvoGApXzVA-HMCY2oOj7kuKKg@mail.gmail.com>
References: <20201102223800.12181-1-ardb@kernel.org>
         <2fd203414ba8ac3349f0109fea633838b4e04f05.camel@linux.ibm.com>
         <CAMj1kXEjKt0F8dZBnF=x2ShkxyvoGApXzVA-HMCY2oOj7kuKKg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_12:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040135
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2020-11-04 at 19:50 +0100, Ard Biesheuvel wrote:
> On Wed, 4 Nov 2020 at 19:20, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > Hi Ard, Chester,
> >
> > On Mon, 2020-11-02 at 23:37 +0100, Ard Biesheuvel wrote:
> > > This is a follow-up to Chester's series [0] to enable IMA to the secure
> > > boot state of arm64 platforms, which is EFI based.
> > >
> > > This v4 implements the changes I suggested to Chester, in particular:
> > > - disregard MokSbState when factoring out secure boot mode discovery
> > > - turn the x86 IMA arch code into shared code for all architectures.
> > >
> > > This reduces the final patch to a one liner enabling a Kconfig option
> > > for arm64 when EFI is enabled.
> > >
> > > Build tested only.
> >
> > Thank you!  This patch set is now queued in the linux-integrity next-
> > integrity-testing branch.
> >
> 
> I don't mind per se, but this touches a number of different trees,
> including x86 and arm64, and nobody has acked it yet.
> 
> As far as the EFI tree is concerned, it looks like I should be able to
> avoid any conflicts with other stuff that is in flight, and if not, we
> can always use your branch up until the last patch in this serires as
> a shared tag (assuming you won't rebase it).

The next-integrity-testing branch is just a place holder waiting for
additional tags.  I've reviewed and tested the patch set on x86.  Based
on the secure boot status and how the kernel is configured, the
appropriate policy rules are enabled.   Similarly the IMA appraise mode
(ima_appraise=) is working properly.  I have not tested on arm64.

I do not have a problem with this patch set being upstream via EFI.

thanks,

Mimi

