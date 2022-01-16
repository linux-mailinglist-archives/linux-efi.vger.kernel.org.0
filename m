Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288B448FA62
	for <lists+linux-efi@lfdr.de>; Sun, 16 Jan 2022 03:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiAPC4f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 15 Jan 2022 21:56:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233348AbiAPC4e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 15 Jan 2022 21:56:34 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20G2Rt5q024133;
        Sun, 16 Jan 2022 02:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ckdBsYQVl/7mxZYEoYZym0Ilx5/7I9XLkGi2fJyNtns=;
 b=I6CvEDhRnuH6+Uj5QXGmvoqMHSDJ4ixSoy1V1zdn5q6/F218S3rWhUAZsDpBudE6XkzJ
 F3qW3tYxuhdqcpYQKfGdenmGxRZwFNoHsUlTgqMG3HJlCxlXQmulDx9dsbeYZrNBF+Fg
 owUe+yrcRR/jfZU0xorVGtbBtTe42r5E9l0fOxiShjKPY788vrb91zCqz/NbUrzMMzeO
 M7Hjbu3eHQ35862PGYXKTABV8Mm5INR4YCbhb4wPgfBnO6i1DUuWsSzcgjC7KXz/3Wzz
 ctSoxOSkf6TGMYyt1HRvSx8MRKg3GsTMRzHIaxh4o5gZXQQ8UBCai9/iZPR2ht59FMOU HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dmaks889h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jan 2022 02:55:55 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20G2tt7l005699;
        Sun, 16 Jan 2022 02:55:55 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dmaks8899-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jan 2022 02:55:54 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20G2rrcp025928;
        Sun, 16 Jan 2022 02:55:53 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3dknw8unsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jan 2022 02:55:52 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20G2toF446268704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Jan 2022 02:55:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FC9FAE051;
        Sun, 16 Jan 2022 02:55:50 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06D45AE04D;
        Sun, 16 Jan 2022 02:55:48 +0000 (GMT)
Received: from sig-9-65-70-246.ibm.com (unknown [9.65.70.246])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 16 Jan 2022 02:55:47 +0000 (GMT)
Message-ID: <f8598ca4e51e0b98aa98a1386c6f40bd04acdf15.camel@linux.ibm.com>
Subject: Re: [PATCH v9 2/8] integrity: Introduce a Linux keyring called
 machine
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>
Cc:     David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "pjones@redhat.com" <pjones@redhat.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Date:   Sat, 15 Jan 2022 21:55:47 -0500
In-Reply-To: <YeMdY+FLM32tmRMz@iki.fi>
References: <20220105235012.2497118-3-eric.snowberg@oracle.com>
         <883da244c04fcb07add9984859a09d7b1827880a.camel@linux.ibm.com>
         <100B070F-7EB4-4BF7-B2B9-E5AE78D3066A@oracle.com>
         <a384fcf8bdd9ff79456e9669fc61ab50ec4e1c55.camel@linux.ibm.com>
         <F1F41DB2-171A-4A6F-9AE7-E03C4D3B7DD0@oracle.com>
         <eece68eba2beceeb410748c1f9f32162793d2057.camel@linux.ibm.com>
         <2d681148b6ea57241f6a7c518dd331068a5f47b0.camel@linux.ibm.com>
         <YeMAURSR8/fRjBHD@iki.fi> <153F495F-EAF9-4C11-A476-293CC3B78F0A@oracle.com>
         <YeMdIrMXbSq7BgzY@iki.fi> <YeMdY+FLM32tmRMz@iki.fi>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HyAFj7hMsrAXWAjr3A45LJ9_OKeIOrQA
X-Proofpoint-GUID: CXPtax3OwNbbwBV_0uaQfvSSR8s-L-pC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-16_01,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201160017
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 2022-01-15 at 21:15 +0200, Jarkko Sakkinen wrote:
> On Sat, Jan 15, 2022 at 09:14:45PM +0200, Jarkko Sakkinen wrote:
> > On Sat, Jan 15, 2022 at 07:12:35PM +0000, Eric Snowberg wrote:
> > > 
> > > 
> > > > On Jan 15, 2022, at 10:11 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > 
> > > > On Wed, Jan 12, 2022 at 02:41:47PM -0500, Mimi Zohar wrote:
> > > >> On Tue, 2022-01-11 at 20:14 -0500, Mimi Zohar wrote:
> > > >>> On Tue, 2022-01-11 at 21:26 +0000, Eric Snowberg wrote:
> > > >>>> 
> > > >>>>> On Jan 11, 2022, at 11:16 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > >>>>> 
> > > >>>>> On Mon, 2022-01-10 at 23:25 +0000, Eric Snowberg wrote:
> > > >>>>>>> Jarkko, my concern is that once this version of the patch set is
> > > >>>>>>> upstreamed, would limiting which keys may be loaded onto the .machine
> > > >>>>>>> keyring be considered a regression?
> > > >>>>>> 
> > > >>>>>> 
> > > >>>>>> Currently certificates built into the kernel do not have a CA restriction on them.  
> > > >>>>>> IMA will trust anything in this keyring even if the CA bit is not set.  While it would 
> > > >>>>>> be advisable for a kernel to be built with a CA, nothing currently enforces it. 
> > > >>>>>> 
> > > >>>>>> My thinking for the dropped CA restriction patches was to introduce a new Kconfig.  
> > > >>>>>> This Kconfig would do the CA enforcement on the machine keyring.  However if the 
> > > >>>>>> Kconfig option was not set for enforcement, it would work as it does in this series, 
> > > >>>>>> plus it would allow IMA to work with non-CA keys.  This would be done by removing 
> > > >>>>>> the restriction placed in this patch. Let me know your thoughts on whether this would 
> > > >>>>>> be an appropriate solution.  I believe this would get around what you are identifying as 
> > > >>>>>> a possible regression.
> > > >>>>> 
> > > >>>>> True the problem currently exists with the builtin keys, but there's a
> > > >>>>> major difference between trusting the builtin keys and those being
> > > >>>>> loading via MOK.  This is an integrity gap that needs to be closed and
> > > >>>>> shouldn't be expanded to keys on the .machine keyring.
> > > >>>>> 
> > > >>>>> "plus it would allow IMA to work with non-CA keys" is unacceptable.
> > > >>>> 
> > > >>>> Ok, I’ll leave that part out.  Could you clarify the wording I should include in the future 
> > > >>>> cover letter, which adds IMA support, on why it is unacceptable for the end-user to
> > > >>>> make this decision?
> > > >>> 
> > > >>> The Kconfig IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
> > > >>> "help" is very clear:
> > > >> 
> > > >> [Reposting the text due to email formatting issues.]
> > > >> 
> > > >> help
> > > >>  Keys may be added to the IMA or IMA blacklist keyrings, if the
> > > >>  key is validly signed by a CA cert in the system built-in or
> > > >>  secondary trusted keyrings.
> > > >> 
> > > >>  Intermediate keys between those the kernel has compiled in and the 
> > > >>  IMA keys to be added may be added to the system secondary keyring,
> > > >>  provided they are validly signed by a key already resident in the
> > > >>  built-in or secondary trusted keyrings.
> > > >> 
> > > >> 
> > > >> The first paragraph requires "validly signed by a CA cert in the system
> > > >> built-in or secondary trusted keyrings" for keys to be loaded onto the
> > > >> IMA keyring.  This Kconfig is limited to just the builtin and secondary
> > > >> keyrings.  Changing this silently to include the ".machine" keyring
> > > >> introduces integrity risks that previously did not exist.  A new IMA
> > > >> Kconfig needs to be defined to allow all three keyrings - builtin,
> > > >> machine, and secondary.
> > > >> 
> > > >> The second paragraph implies that only CA and intermediate CA keys are
> > > >> on secondary keyring, or as in our case the ".machine" keyring linked
> > > >> to the secondary keyring.
> > > >> 
> > > >> Mimi
> > > >> 
> > > > I have also now test environment for this patch set but if there are
> > > > any possible changes, I'm waiting for a new version, as it is anyway
> > > > for 5.18 cycle earliest.
> > > 
> > > Other than the two sentence changes, I have not seen anything identified 
> > > code wise requiring a change.  If you’d like me to respin a v10 with the sentence 
> > > changes let me know.  Or if you want to remove the ima reference, that works 
> > > too.  Just let me know how you want to handle this.  Thanks.
> > 
> > I'm basically waiting also Mimi to test this as I do not have IMA test
> > environment.
> > 
> > From my side:
> > 
> > Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> I can pick the whole thing at the time when I get green light.

The MOK keys are not loaded onto the .machine keyring if
CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is enabled. 
From an IMA perspective nothing has changed.

After the IMA references in the patch descriptions are removed, feel
free to add Tested-by: Mimi Zohar <zohar@linux.ibm.com> on patches 1 -
5.

thanks,

Mimi

