Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1AA3B6E0F
	for <lists+linux-efi@lfdr.de>; Tue, 29 Jun 2021 08:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhF2GHq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Jun 2021 02:07:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4938 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231881AbhF2GHg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Jun 2021 02:07:36 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15T64M61077663;
        Tue, 29 Jun 2021 02:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=AlpvKOKBWbtrP8/Afnp56Pm7GdYimJlG8sWsm5x5Rx4=;
 b=jkak/l53wmqq8ZUPvxJUpZeXGoRpao20lJvetikKwJE4/tbSOqmjv2In2Jub43BUXmOF
 2jySiguPbDv5FVbvjKV2c43Rnw9mGSv75q1ctvXa3p5BjYceWfELjRwHK9sy1wnE45zb
 laQPMQcqAORazyGeAA9n67PQQVrbkarvTkobkZA9OcCi5zJ35paNnzx6wDQQ3L+QLcFq
 nEIS8x1S3r0czay11sCaNhtv/fEgPBsD8zwuim0dHmU7GYOFwE6wGJPo5PBqTCNNi8VN
 cWeFOs6YytzS7/lrU3Gxh7B4tgX57oPK4qEORU00yEjZyofgunm/GbzI+rhLhMzVOgn1 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fv2ctfc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 02:05:01 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15T64Urt078278;
        Tue, 29 Jun 2021 02:05:00 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fv2ctfbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 02:05:00 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15T62c4J027760;
        Tue, 29 Jun 2021 06:04:59 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 39duv8gjtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 06:04:58 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15T64tvg27328796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 06:04:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9617A40D7;
        Tue, 29 Jun 2021 06:04:54 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 471D8A407D;
        Tue, 29 Jun 2021 06:04:50 +0000 (GMT)
Received: from [9.160.49.135] (unknown [9.160.49.135])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Jun 2021 06:04:49 +0000 (GMT)
Subject: Re: [RFC PATCH v2 2/3] efi: Reserve confidential computing secret
 area
To:     Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org
Cc:     Laszlo Ersek <lersek@redhat.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>, linux-coco@lists.linux.dev,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210628183431.953934-1-dovmurik@linux.ibm.com>
 <20210628183431.953934-3-dovmurik@linux.ibm.com>
 <9b9b682f-297e-9ebd-4d67-43c3ed9ad8c5@amd.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
Message-ID: <996db75c-5648-17b1-5bae-f3b10d72c110@linux.ibm.com>
Date:   Tue, 29 Jun 2021 09:04:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9b9b682f-297e-9ebd-4d67-43c3ed9ad8c5@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aZufCRSzQhsAwgYeak7KS2ftPBjDJ4mM
X-Proofpoint-GUID: _HvNLJMku3LJoaLB_n9Rwfz3P-avA3HV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_02:2021-06-25,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106290039
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Tom,

On 28/06/2021 23:40, Tom Lendacky wrote:
> On 6/28/21 1:34 PM, Dov Murik wrote:
>> When efi-stub copies an EFI-provided confidential computing secret area,
>> reserve that memory block for future use within the kernel.
>>
>> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
>> ---
>>  drivers/firmware/efi/Makefile                 |  2 +-
>>  drivers/firmware/efi/confidential-computing.c | 41 +++++++++++++++++++
>>  drivers/firmware/efi/efi.c                    |  5 +++
>>  include/linux/efi.h                           |  4 ++
>>  4 files changed, 51 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/firmware/efi/confidential-computing.c
>>
>> diff --git a/include/linux/efi.h b/include/linux/efi.h
>> index 4f647f1ee298..e9740bd16db0 100644
>> --- a/include/linux/efi.h
>> +++ b/include/linux/efi.h
>> @@ -551,6 +551,8 @@ extern struct efi {
>>  	unsigned long			tpm_log;		/* TPM2 Event Log table */
>>  	unsigned long			tpm_final_log;		/* TPM2 Final Events Log table */
>>  	unsigned long			mokvar_table;		/* MOK variable config table */
>> +	unsigned long			confidential_computing_secret;	/* Confidential computing */
>> +									/* secret table           */
> 
> If there is any possibility that someone could reuse a form of this
> confidential computing secret table in a bare metal system, then this
> table needs to be added to the efi_tables[] array in
> arch/x86/platform/efi/efi.c. Otherwise, it will be mapped improperly on a
> system with SME active.

Good catch, thanks.  I see that all existing table addresses from
struct efi are added to the efi_tables[] array, so for completeness it
makes sense to add efi.confidential_computing_secret as well (even
though currently bare metal firmware doesn't have this table).

Thanks,
-Dov


> 
> Thanks,
> Tom
> 
>>  
>>  	efi_get_time_t			*get_time;
>>  	efi_set_time_t			*set_time;
>> @@ -1190,6 +1192,8 @@ extern int efi_tpm_final_log_size;
>>  
>>  extern unsigned long rci2_table_phys;
>>  
>> +extern int efi_confidential_computing_secret_area_reserve(void);
>> +
>>  /*
>>   * efi_runtime_service() function identifiers.
>>   * "NONE" is used by efi_recover_from_page_fault() to check if the page
>>
