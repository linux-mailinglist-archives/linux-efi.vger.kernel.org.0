Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81338434585
	for <lists+linux-efi@lfdr.de>; Wed, 20 Oct 2021 08:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJTGyT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Oct 2021 02:54:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229591AbhJTGyS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Oct 2021 02:54:18 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K4fWbA019095;
        Wed, 20 Oct 2021 02:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=lZohXjccNZKaevkSlN6nCnCXWtpsN2RZblraazDcLYs=;
 b=Q2p7zJzFTkaHED46+ya3bIRwZiknVgYTXg+x+UjI/md8RyV6vUamFYLjRz+qg/xUx94V
 t9Au+tBJ2WnlILyzjpO6kad4iJdG6wEUBv6qj77tLlEXobe7shivkLdE03XZxaobJQSv
 apwsTZMBEoX1LDgwGEwJoqCoAACKhSLMATdnOlmfkVZdNf9KAyp3vf8aI8HYRsQRjZCA
 qd9QNb7iNSIKhokfVtmHDH30RgVbLIPtzV/o8jIfvR/PptGmsC7wkAqXp1/RvI3XWmTp
 Z+Mo2vhrAVXmoyMVCt6pDsC7VCynp/tBJ4sKz2RWAO4817wal8TQUsri08vemNSNHL/U 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3btca9tamg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 02:51:41 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19K4gpLF021465;
        Wed, 20 Oct 2021 02:51:40 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3btca9tam4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 02:51:40 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19K6lxYW001020;
        Wed, 20 Oct 2021 06:51:39 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02wdc.us.ibm.com with ESMTP id 3bqpcbf4fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 06:51:39 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19K6pb0w36700426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 06:51:37 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CE256A054;
        Wed, 20 Oct 2021 06:51:37 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 886CF6A04D;
        Wed, 20 Oct 2021 06:51:32 +0000 (GMT)
Received: from [9.160.85.241] (unknown [9.160.85.241])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 20 Oct 2021 06:51:32 +0000 (GMT)
Message-ID: <6396fec0-7a43-1cc7-44bb-064ab80d2139@linux.ibm.com>
Date:   Wed, 20 Oct 2021 09:51:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 2/3] efi: Reserve confidential computing secret area
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
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
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>
References: <20211014130848.592611-1-dovmurik@linux.ibm.com>
 <20211014130848.592611-3-dovmurik@linux.ibm.com> <YWgyWeoreYusT9/s@kroah.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <YWgyWeoreYusT9/s@kroah.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oiPgdwLVy5IhZv40HMNyD_RjC6WbjBnE
X-Proofpoint-ORIG-GUID: Eh50zcXs1gQKFsJNYRSIXniduEQBCcV1
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_02,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200034
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 14/10/2021 16:36, Greg KH wrote:
> On Thu, Oct 14, 2021 at 01:08:47PM +0000, Dov Murik wrote:
>> When efi-stub copies an EFI-provided confidential computing (coco)
>> secret area, reserve that memory block for future use within the kernel.
>>
>> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
>> ---
>>  arch/x86/platform/efi/efi.c   |  1 +
>>  drivers/firmware/efi/Makefile |  2 +-
>>  drivers/firmware/efi/coco.c   | 41 +++++++++++++++++++++++++++++++++++
>>  drivers/firmware/efi/efi.c    |  4 ++++
>>  include/linux/efi.h           |  3 +++
>>  5 files changed, 50 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/firmware/efi/coco.c
>>
>> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
>> index 147c30a81f15..35e082e5f603 100644
>> --- a/arch/x86/platform/efi/efi.c
>> +++ b/arch/x86/platform/efi/efi.c
>> @@ -93,6 +93,7 @@ static const unsigned long * const efi_tables[] = {
>>  #ifdef CONFIG_LOAD_UEFI_KEYS
>>  	&efi.mokvar_table,
>>  #endif
>> +	&efi.coco_secret,
> 
> Shouldn't this depend on CONFIG_EFI_SECRET?
> 
> Why build all of this code if that option is not enabled?
> 

Thanks Greg for noticing this.  Fixed in v4 [1] where the code
is guarded with #ifdefs (so it's not built by default).

[1] https://lore.kernel.org/linux-coco/20211020061408.3447533-1-dovmurik@linux.ibm.com/

-Dov
