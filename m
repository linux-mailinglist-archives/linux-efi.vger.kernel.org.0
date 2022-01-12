Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE1C48BC58
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jan 2022 02:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347653AbiALBUR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jan 2022 20:20:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235700AbiALBUQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jan 2022 20:20:16 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20C0O5t4023011;
        Wed, 12 Jan 2022 01:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=c42CtGU/CpVjRehZZ2MVHeZM67AscNu6P87M6JA8AyU=;
 b=JE4QF4i2R+iyDN++sAxz9S67ziujTnVwlAgALgXsZcX1vnvdY+Ntbg/qKegisTjzmxxN
 BrOfepKxUQWITyWymnTCOb8QiAJqAZogBsjo9uQD6Yadv7NbUabEkUfkT3OZa5HT0wbG
 UWp/pWvhhgwKghQazp5mXMVkooM9jD9UOxy9ChtIYC2y11IZ1TpjXOpyAdj+hSdNteZd
 v6/R11ZrChpYeVFH1Exc+tsiGR36lLcaBOxA40bqShxuJS9ajhLrK6mKTjL28W2exqk1
 6IKRg8DdSRjb17/vrq+fOCRPmTXrY17sgK9f9qoicA0bYYmH1zRyS35zyxhMrLyHtMGY Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dhes3qc5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 01:15:00 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20C0tRnF017092;
        Wed, 12 Jan 2022 01:14:59 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dhes3qc4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 01:14:59 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20C17x3s013496;
        Wed, 12 Jan 2022 01:14:57 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3df28a3705-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 01:14:57 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20C1EsS245023524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 01:14:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1C31A405D;
        Wed, 12 Jan 2022 01:14:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 754B2A404D;
        Wed, 12 Jan 2022 01:14:52 +0000 (GMT)
Received: from sig-9-65-73-162.ibm.com (unknown [9.65.73.162])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 12 Jan 2022 01:14:52 +0000 (GMT)
Message-ID: <eece68eba2beceeb410748c1f9f32162793d2057.camel@linux.ibm.com>
Subject: Re: [PATCH v9 2/8] integrity: Introduce a Linux keyring called
 machine
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
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
        <James.Bottomley@HansenPartnership.com>,
        "pjones@redhat.com" <pjones@redhat.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Date:   Tue, 11 Jan 2022 20:14:51 -0500
In-Reply-To: <F1F41DB2-171A-4A6F-9AE7-E03C4D3B7DD0@oracle.com>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
         <20220105235012.2497118-3-eric.snowberg@oracle.com>
         <883da244c04fcb07add9984859a09d7b1827880a.camel@linux.ibm.com>
         <100B070F-7EB4-4BF7-B2B9-E5AE78D3066A@oracle.com>
         <a384fcf8bdd9ff79456e9669fc61ab50ec4e1c55.camel@linux.ibm.com>
         <F1F41DB2-171A-4A6F-9AE7-E03C4D3B7DD0@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v9ZfVTaGX5SLpgVQ9968umT3K05CbvOz
X-Proofpoint-ORIG-GUID: aVHwVUm7wn-qLpmoBh9aVGHeQyc7Ibxh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 mlxscore=0 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201120002
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2022-01-11 at 21:26 +0000, Eric Snowberg wrote:
> 
> > On Jan 11, 2022, at 11:16 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Mon, 2022-01-10 at 23:25 +0000, Eric Snowberg wrote:
> >>> Jarkko, my concern is that once this version of the patch set is
> >>> upstreamed, would limiting which keys may be loaded onto the .machine
> >>> keyring be considered a regression?
> >> 
> >> 
> >> Currently certificates built into the kernel do not have a CA restriction on them.  
> >> IMA will trust anything in this keyring even if the CA bit is not set.  While it would 
> >> be advisable for a kernel to be built with a CA, nothing currently enforces it. 
> >> 
> >> My thinking for the dropped CA restriction patches was to introduce a new Kconfig.  
> >> This Kconfig would do the CA enforcement on the machine keyring.  However if the 
> >> Kconfig option was not set for enforcement, it would work as it does in this series, 
> >> plus it would allow IMA to work with non-CA keys.  This would be done by removing 
> >> the restriction placed in this patch. Let me know your thoughts on whether this would 
> >> be an appropriate solution.  I believe this would get around what you are identifying as 
> >> a possible regression.
> > 
> > True the problem currently exists with the builtin keys, but there's a
> > major difference between trusting the builtin keys and those being
> > loading via MOK.  This is an integrity gap that needs to be closed and
> > shouldn't be expanded to keys on the .machine keyring.
> > 
> > "plus it would allow IMA to work with non-CA keys" is unacceptable.
> 
> Ok, I’ll leave that part out.  Could you clarify the wording I should include in the future 
> cover letter, which adds IMA support, on why it is unacceptable for the end-user to
> make this decision?

The Kconfig IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
"help" is very clear:

        help
          Keys may be added to the IMA or IMA blacklist keyrings, if
the
          key is validly signed by a CA cert in the system built-in or
          secondary trusted keyrings.

          Intermediate keys between those the kernel has compiled in
and the
          IMA keys to be added may be added to the system secondary
keyring,
          provided they are validly signed by a key already resident in
the
          built-in or secondary trusted keyrings.

Mimi

