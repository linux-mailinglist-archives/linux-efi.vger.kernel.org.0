Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F03D48B595
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 19:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344789AbiAKSTP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jan 2022 13:19:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344629AbiAKSTL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jan 2022 13:19:11 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BHdmUx000777;
        Tue, 11 Jan 2022 18:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=f23pSkAQkmTfG63MYPw5lvGkPGpCHSGtCMNQ0RMPVVw=;
 b=N+it7FobbBF3xJcmaNg2iZZ98mYKy6HWCX+u8RfBEw1GG7keGo90reSd69lYwS0WJHuK
 loz4psJdgKhiSFY8/6YeQOlTmpq7hYJlDVeifMzDYezPJPhxG5wTCZg1h4KGL0W+CUvH
 c+UIkBqMgIYHYPUZYVW1trpsRaf7PaE0eTGT4P0IBT7HHnnqjz5kkwIR/uqV46WkryRz
 cUyagGQPvwlIj327i35I3wXvbkp2ZR1gt3ZaL4JqBJJrq4/uF/yi5kJSNfJK0qTAnVFT
 9zb4jLQHby+Y6QDkWZZD0FoVcOtQ0N5k1bXjLNC0QD3GrSOmCj2l2jE65WRU72kBofS6 zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dhbp7e0pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 18:16:45 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20BIDEJU016077;
        Tue, 11 Jan 2022 18:16:44 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dhbp7e0nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 18:16:44 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20BIFZZY006044;
        Tue, 11 Jan 2022 18:16:41 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3df2892wsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 18:16:41 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20BIGdvP45875706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 18:16:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4395611C050;
        Tue, 11 Jan 2022 18:16:39 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C56911C05B;
        Tue, 11 Jan 2022 18:16:37 +0000 (GMT)
Received: from sig-9-65-94-95.ibm.com (unknown [9.65.94.95])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jan 2022 18:16:36 +0000 (GMT)
Message-ID: <a384fcf8bdd9ff79456e9669fc61ab50ec4e1c55.camel@linux.ibm.com>
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
Date:   Tue, 11 Jan 2022 13:16:36 -0500
In-Reply-To: <100B070F-7EB4-4BF7-B2B9-E5AE78D3066A@oracle.com>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
         <20220105235012.2497118-3-eric.snowberg@oracle.com>
         <883da244c04fcb07add9984859a09d7b1827880a.camel@linux.ibm.com>
         <100B070F-7EB4-4BF7-B2B9-E5AE78D3066A@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GtMCw9gU-05vUSKvCgnmnFZN-mUkf-aF
X-Proofpoint-ORIG-GUID: zoiRmxjG6RJRitTOPoRW8Bc1iQ31vQ07
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201110098
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2022-01-10 at 23:25 +0000, Eric Snowberg wrote:
> > Jarkko, my concern is that once this version of the patch set is
> > upstreamed, would limiting which keys may be loaded onto the .machine
> > keyring be considered a regression?
> 
> 
> Currently certificates built into the kernel do not have a CA restriction on them.  
> IMA will trust anything in this keyring even if the CA bit is not set.  While it would 
> be advisable for a kernel to be built with a CA, nothing currently enforces it. 
> 
> My thinking for the dropped CA restriction patches was to introduce a new Kconfig.  
> This Kconfig would do the CA enforcement on the machine keyring.  However if the 
> Kconfig option was not set for enforcement, it would work as it does in this series, 
> plus it would allow IMA to work with non-CA keys.  This would be done by removing 
> the restriction placed in this patch. Let me know your thoughts on whether this would 
> be an appropriate solution.  I believe this would get around what you are identifying as 
> a possible regression.

True the problem currently exists with the builtin keys, but there's a
major difference between trusting the builtin keys and those being
loading via MOK.  This is an integrity gap that needs to be closed and
shouldn't be expanded to keys on the .machine keyring.

"plus it would allow IMA to work with non-CA keys" is unacceptable.

Mimi

