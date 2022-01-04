Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DE3483C1C
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jan 2022 08:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiADHCi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Jan 2022 02:02:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26578 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233043AbiADHCi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Jan 2022 02:02:38 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2045J4tP020341;
        Tue, 4 Jan 2022 07:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3wk2/neUEX85QFNkkO+Oosbsw9CiybuKQaIw/z1E9Uw=;
 b=jHZiCTSvxEbcv9IQDtPMAM9qnU4L3FbNvzmzli2JDdiBfarpJBSXrdg9+GG6ZeWfmYh6
 4oe/UrBn2C3Xj4TgIoUdAhWjIfu8D7LBps2V9fYAuPyOQloU/Id9iw2zWqLZ6FXQROLr
 W1vWUQx7OxPV4mQ0/HJgEnRHcW8fdbNbjWIKRLhTAv92maW+x/LN85C5qalAwPySQS1V
 wc7b+uOuYifgjIzX2vW+BjG2JVDBWiiHEiZbtLmxgIh5wyMCo0qlJ6XWghVZmgSnvwiw
 THu7IE5JeC1RnhB10RSQfiVQvoQl72BhvohHSs1eXM/v61+YWYBNZLzy5yYzVuj0MUDJ wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dcb2bdfsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 07:02:13 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2046jOCa021625;
        Tue, 4 Jan 2022 07:02:12 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dcb2bdfsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 07:02:12 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2046sB5S008481;
        Tue, 4 Jan 2022 07:02:10 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02wdc.us.ibm.com with ESMTP id 3daeka5cwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 07:02:10 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2047292k30278024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jan 2022 07:02:09 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E60C6E053;
        Tue,  4 Jan 2022 07:02:09 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCDFA6E056;
        Tue,  4 Jan 2022 07:02:04 +0000 (GMT)
Received: from [9.160.161.139] (unknown [9.160.161.139])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jan 2022 07:02:04 +0000 (GMT)
Message-ID: <0280e20e-8459-dd35-0b7d-8dbc1e4a274a@linux.ibm.com>
Date:   Tue, 4 Jan 2022 09:02:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v6 0/5] Allow guest access to EFI confidential computing
 secret area
Content-Language: en-US
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-efi@vger.kernel.org, Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>
References: <20211129114251.3741721-1-dovmurik@linux.ibm.com>
 <YdNHgtuVoLofL4cW@zn.tnic>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <YdNHgtuVoLofL4cW@zn.tnic>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3wgLohTNv17_5gRZNiogkFECRPbcAEpg
X-Proofpoint-GUID: ff3sx0Y1crIH928XegyGBpeL5Z6Gow7J
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_03,2022-01-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201040047
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Boris,

On 03/01/2022 20:59, Borislav Petkov wrote:
> On Mon, Nov 29, 2021 at 11:42:46AM +0000, Dov Murik wrote:
>> As a usage example, consider a guest performing computations on
>> encrypted files.  The Guest Owner provides the decryption key (= secret)
>> using the secret injection mechanism.  The guest application reads the
>> secret from the efi_secret filesystem and proceeds to decrypt the files
>> into memory and then performs the needed computations on the content.
>>
>> In this example, the host can't read the files from the disk image
>> because they are encrypted.  Host can't read the decryption key because
>> it is passed using the secret injection mechanism (= secure channel).
>> Host can't read the decrypted content from memory because it's a
>> confidential (memory-encrypted) guest.
> 
> So maybe I don't understand the example properly or something's missing
> but why can't the guest owner simply scp the secrets into the guest? Why
> is this special thing needed?

If the Guest Owner chooses to inject secrets via scp, it needs
to be sure it is scp-ing to the correct VM - the one that has SEV
enabled and was measured at launch.

One way to achieve that would be to inject the guest's SSH private key
using the proposed efi_secret mechanism.  This way the Guest Owner is
sure it is talking to the correct guest and not to some other VM that
was started by the untrusted cloud provider (say, with SEV disabled so
the cloud provider can steal its memory content).


> 
> The secret below says "...kata-secrets" so this sounds like
> something-automated-containers-thing where they'd profit from getting
> secrets automatically supplied to the guest. But I guess there you can
> scp too...

Indeed this proposed efi_secret module is in use for enabling SEV
confidential containers using Kata containers [1], but there's nothing
specific in the current patch series about containers.  The patch series
just exposes the launch-injected SEV secrets to userspace as virtual files
(under securityfs).

[1] https://github.com/confidential-containers/attestation-agent/tree/main/src/kbc_modules/offline_sev_kbc


> 
> So what am I missing?
> 

It boils down to: the confidential guest needs to have access to a
secret which the untrusted host can't read, and which is essential for
the normal operation of the guest.  This secret can be a decryption key,
an SSH private key, an API key to a Key Management system, etc.  If a
malicious cloud provider tries to start that VM without a secret (or
with the wrong one), the actual workload that the guest is supposed to
run will not execute meaningfully.

The proposed patch series exposes the SEV injected secrets as virtual
files, which can later be used as decryption keys (as done in the kata
confidential containers use-case), or SSH private keys, or any other
possible implementation.

-Dov
