Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BECF38ED9A
	for <lists+linux-efi@lfdr.de>; Mon, 24 May 2021 17:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhEXPjj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 May 2021 11:39:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233666AbhEXPh2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 May 2021 11:37:28 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14OFYce3115652;
        Mon, 24 May 2021 11:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=0GUyE5bYVPf1EOavZNI3brZReI/hBFug03qUKRSri0Y=;
 b=cn3oOIjq1VQObdr3uVRjXwzOxs7ILCikqZ5wOK4093NGx0/qaKaQzLPiikrOsxuufToB
 RUI/TlxSJR3RMlza8deZRhUi4aDzrCjOVnOm2jc8soxhvdkZ1EAOOvuf0j5oLeI2EEns
 vxUDlTcqjlc5Y7hhUm5ckCZ+IZvShYwbFydz8DTDEsyh/929ludo9By3KnslxBcDSYjU
 bNvEF6IcH6JOvWghX388ocAPdgYEJWQazZaLp/6xwpCI7R6jW/viRMW8qLd7WjuyG0g+
 mHUPaqflKb6xx885NfmfzLgi6mRpijrsx+snWUprZad/8jGih0uzpgDmhSGjq1UMaDAC Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38rcd5n7eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 11:35:47 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14OFYdrs115807;
        Mon, 24 May 2021 11:35:46 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38rcd5n7e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 11:35:46 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14OFX5qc015612;
        Mon, 24 May 2021 15:35:45 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04dal.us.ibm.com with ESMTP id 38psk8uymv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 15:35:45 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14OFZhOI13173016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 15:35:43 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19D6278067;
        Mon, 24 May 2021 15:35:43 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C042D7805F;
        Mon, 24 May 2021 15:35:39 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.80.208.94])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 24 May 2021 15:35:39 +0000 (GMT)
Message-ID: <d7841acd416f9437b532a4acf65cfc46762ef79d.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 0/3] Allow access to confidential computing secret
 area
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dov Murik <dovmurik@linux.ibm.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, linux-efi@vger.kernel.org,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Mon, 24 May 2021 08:35:38 -0700
In-Reply-To: <YKuXI9TUBa3sjY3e@work-vm>
References: <20210513062634.2481118-1-dovmurik@linux.ibm.com>
         <2c8ae998-6dd0-bcb9-f735-e90da05ab9d9@amd.com> <YKZAUdbikp2Pt0XV@work-vm>
         <ccdf0059-7e39-7895-2733-412dbe4b13f1@linux.intel.com>
         <c316c49c-03db-22e3-0072-ebaf3c7f2ca2@amd.com>
         <45842efd-7b6b-496f-d161-e5786760078d@linux.intel.com>
         <YKuXI9TUBa3sjY3e@work-vm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QlVb6q4H6y_9lu-lAoKWz9WFq28EbZbP
X-Proofpoint-ORIG-GUID: EGyF6gCjMd9VCPvyiKfZ3eBEiFDzeXil
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-24_08:2021-05-24,2021-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105240095
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2021-05-24 at 13:08 +0100, Dr. David Alan Gilbert wrote:
> * Andi Kleen (ak@linux.intel.com) wrote:
[...]
> > We opted to use ioctls, with the idea that it should be just read
> > and cleared once to not let the secret lying around. Typically you
> > would just use it to set up dmcrypt or similar once. I think read-
> > and-clear with explicit operations is a better model than some
> > virtual file because of the security properties.
> 
> Do you think the ioctl is preferable to read+ftruncate/unlink ?

I really think if we do a unified upper interface it should be file
based.  An ioctl based on will have too much temptation to expose the
architecture of the underlying system.  However, the way to explore
this would be to ask if there's anything the current ioctl based one
can do that a file based one couldn't?

I think ftruncate/unlink is a preferable interface because it puts the
control in the hands of the consumer: you don't know how far the secret
might get shared, so by doing clear on first read the driver is forcing
the user implementation to cache it instead, thus shifting the problem
not solving it.

James


