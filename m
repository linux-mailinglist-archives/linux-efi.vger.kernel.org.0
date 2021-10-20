Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EE6434B98
	for <lists+linux-efi@lfdr.de>; Wed, 20 Oct 2021 14:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJTMz1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Oct 2021 08:55:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229817AbhJTMz1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Oct 2021 08:55:27 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KBGer5014964;
        Wed, 20 Oct 2021 08:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dosEoDlYtTInTfi1/yQjumNEs7jtVu68a+r+D2/Dpko=;
 b=Xd8lAlXjGHdnA2F530UfWnwbebYEmsVnl8NNuTKcFiDuzfPr18wHIUzCsgJSd4+xQksc
 /VhLFseOesFDcSDvp/zN2zc3mezBcIFCyN76JD5tE+XYzCgw5hRgHoe1UQrVvPE64kdu
 d0UhXueDLhinTMjm5/fiLH3GA4Hk171kMRXZJDsQYh6qIbCisY4GMJFNMNrHQRHyH4+m
 ZsrC9P9VDN40VnYEE97o9XaBUyxbd4AagogjgrvJeJGW7z80aqztCObK64TzztxppYJm
 nUPghAfdbEOP9pTexwKOIz1jHc7hjHtthToqjtfvoROxK1Fx0J8pc8tSc8l+pnU1YEgn NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3btj3mt0vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 08:53:00 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19KC0KPh000593;
        Wed, 20 Oct 2021 08:52:59 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3btj3mt0un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 08:52:59 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19KCm2o4014037;
        Wed, 20 Oct 2021 12:52:57 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03wdc.us.ibm.com with ESMTP id 3bt4ss5vbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 12:52:57 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19KCqtr153412148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 12:52:55 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 877156A058;
        Wed, 20 Oct 2021 12:52:55 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3529B6A063;
        Wed, 20 Oct 2021 12:52:50 +0000 (GMT)
Received: from [9.160.85.241] (unknown [9.160.85.241])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 20 Oct 2021 12:52:49 +0000 (GMT)
Message-ID: <bfa4872d-f64a-0559-1c5d-c5d1ae333eee@linux.ibm.com>
Date:   Wed, 20 Oct 2021 15:52:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 1/3] efi/libstub: Copy confidential computing secret
 area
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>
References: <20211020061408.3447533-1-dovmurik@linux.ibm.com>
 <20211020061408.3447533-2-dovmurik@linux.ibm.com>
 <YW+5phDcxynJD2qy@kroah.com>
 <fb309e2686ca42df2c053cc1b060b1bc774fd3e7.camel@linux.ibm.com>
 <YXAHgkcfwSCBeCbh@kroah.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <YXAHgkcfwSCBeCbh@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OyB3zMS8e-9L6NOZrI_Bg92OFViYc8s0
X-Proofpoint-ORIG-GUID: DBap7xKIVhMrvg7LFGHxKYHR_vkG6y_z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_04,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200072
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 20/10/2021 15:11, Greg KH wrote:
> On Wed, Oct 20, 2021 at 08:00:28AM -0400, James Bottomley wrote:
>> On Wed, 2021-10-20 at 08:39 +0200, Greg KH wrote:
>>> On Wed, Oct 20, 2021 at 06:14:06AM +0000, Dov Murik wrote:
>> [...]
>>>> +	help
>>>> +	  Copy memory reserved by EFI for Confidential Computing (coco)
>>>> +	  injected secrets, if EFI exposes such a table entry.
>>>
>>> Why would you want to "copy" secret memory?
>>>
>>> This sounds really odd here, it sounds like you are opening up a
>>> security hole.  Are you sure this is the correct text that everyone
>>> on the "COCO" group agrees with?
>>
>> The way this works is that EFI covers the secret area with a boot time
>> handoff block, which means it gets destroyed as soon as
>> ExitBootServices is called as a security measure ... if you do nothing
>> the secret is shredded.  This means you need to make a copy of it
>> before that happens if there are secrets that need to live beyond the
>> EFI boot stub.
> 
> Ok, but "copy secrets" does sound really odd, so you all need a much
> better description here, and hopefully somewhere else in Documentation/
> to describe exactly what this new API is and is to be used for.
> 


So something like:


config EFI_COCO_SECRET
	bool "Keep the EFI Confidential Computing secret area"
	depends on EFI
	help
	  Confidential Computing platforms (such as AMD SEV) allow for
	  secrets injection during guest VM launch.  The secrets are
	  placed in a designated EFI memory area.  EFI destorys
	  the confidential computing secret area when ExitBootServices
	  is called.

	  In order to use the secrets in the kernel, the secret area
	  must be copied to kernel-reserved memory (before it is erased).

	  If you say Y here, the EFI stub will copy the EFI secret area (if
	  available) and reserve it for use inside the kernel.  This will
	  allow the virt/coco/efi_secret module to access the secrets.



and some new file like Documentation/security/coco/efi_secret.rst which
describes this whole protocol (from secret injection at VM launch
into an EFI page, through efistub and efi in linux, to the efi_secret
module which exposes the secrets).


Is that what you're looking for?



> Otherwise I read this as "hey a backdoor to read the secrets I wasn't
> supposed to be able to see!"
> 

Note that both EFI and kernel (and userspace, for that matter) are inside
the trusted zone in terms of AMD SEV (host/hypervisor => untrusted,
guest VM => trusted).  So it's OK for the guest kernel to see these secrets.


-Dov

> thanks,
> 
> greg k-h
> 
