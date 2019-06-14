Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9784745DA8
	for <lists+linux-efi@lfdr.de>; Fri, 14 Jun 2019 15:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfFNNOM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Jun 2019 09:14:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726874AbfFNNOM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 14 Jun 2019 09:14:12 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5ED7vRg118625;
        Fri, 14 Jun 2019 09:13:32 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t4bfvj5v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jun 2019 09:13:32 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5EDD25B005527;
        Fri, 14 Jun 2019 13:13:29 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04dal.us.ibm.com with ESMTP id 2t1xj31bd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jun 2019 13:13:29 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5EDDRSK36241758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jun 2019 13:13:27 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88C366A047;
        Fri, 14 Jun 2019 13:13:27 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 330316A05A;
        Fri, 14 Jun 2019 13:13:25 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.207.125])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jun 2019 13:13:24 +0000 (GMT)
Subject: Re: [PATCH 2/2] powerpc: expose secure variables via sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>
References: <1560459027-5248-1-git-send-email-nayna@linux.ibm.com>
 <1560459027-5248-3-git-send-email-nayna@linux.ibm.com>
 <20190614063443.GB17056@kroah.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <2f4a3ab4-8e9c-a8fc-ba1a-71cf6a9fbb59@linux.vnet.ibm.com>
Date:   Fri, 14 Jun 2019 09:13:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190614063443.GB17056@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140111
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 06/14/2019 02:34 AM, Greg Kroah-Hartman wrote:
> On Thu, Jun 13, 2019 at 04:50:27PM -0400, Nayna Jain wrote:
>> As part of PowerNV secure boot support, OS verification keys are stored
>> and controlled by OPAL as secure variables. These need to be exposed to
>> the userspace so that sysadmins can perform key management tasks.
>>
>> This patch adds the support to expose secure variables via a sysfs
>> interface It reuses the the existing efi defined hooks and backend in
>> order to maintain the compatibility with the userspace tools.
>>
>> Though it reuses a great deal of efi, POWER platforms do not use EFI.
>> A new config, POWER_SECVAR_SYSFS, is defined to enable this new sysfs
>> interface.
>>
>> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
>> ---
>>   arch/powerpc/Kconfig                 |   2 +
>>   drivers/firmware/Makefile            |   1 +
>>   drivers/firmware/efi/efivars.c       |   2 +-
>>   drivers/firmware/powerpc/Kconfig     |  12 +
>>   drivers/firmware/powerpc/Makefile    |   3 +
>>   drivers/firmware/powerpc/efi_error.c |  46 ++++
>>   drivers/firmware/powerpc/secvar.c    | 326 +++++++++++++++++++++++++++
>>   7 files changed, 391 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/firmware/powerpc/Kconfig
>>   create mode 100644 drivers/firmware/powerpc/Makefile
>>   create mode 100644 drivers/firmware/powerpc/efi_error.c
>>   create mode 100644 drivers/firmware/powerpc/secvar.c
> If you add/remove/modify sysfs files, you also need to update the
> relevant Documentation/ABI/ entry as well.  Please add something there
> to describe your new files when you resend the next version of this
> patch series.
>
>> diff --git a/drivers/firmware/powerpc/Kconfig b/drivers/firmware/powerpc/Kconfig
>> new file mode 100644
>> index 000000000000..e0303fc517d5
>> --- /dev/null
>> +++ b/drivers/firmware/powerpc/Kconfig
>> @@ -0,0 +1,12 @@
>> +config POWER_SECVAR_SYSFS
>> +	tristate "Enable sysfs interface for POWER secure variables"
>> +	default n
> default is always n, no need to list it.
>
>> --- /dev/null
>> +++ b/drivers/firmware/powerpc/efi_error.c
>> @@ -0,0 +1,46 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2019 IBM Corporation
>> + * Author: Nayna Jain <nayna@linux.ibm.com>
>> + *
>> + * efi_error.c
>> + *      - Error codes as understood by efi based tools
>> + *      Taken from drivers/firmware/efi/efi.c
> Why not just export the symbol from the original file instead of
> duplicating it here?
>
>> +static int convert_buffer_to_efi_guid(u8 *buffer, efi_guid_t *guid)
>> +{
>> +	u32 *a1;
>> +	u16 *a2;
>> +	u16 *a3;
>> +
>> +	a1 = kzalloc(4, GFP_KERNEL);
> No error checking in this function for memory issues at all?
>
>> +	memcpy(a1, buffer, 4);
>> +	*a1 = be32_to_cpu(*a1);
>> +
>> +	a2 = kzalloc(2, GFP_KERNEL);
>> +	memcpy(a2, buffer+4, 2);
>> +	*a2 = be16_to_cpu(*a2);
>> +
>> +	a3 = kzalloc(2, GFP_KERNEL);
>> +	memcpy(a3, buffer+6, 2);
>> +	*a3 = be16_to_cpu(*a3);
>> +
>> +	*guid = EFI_GUID(*a1, *a2, *a3, *(buffer + 8),
>> +			*(buffer + 9),
>> +			*(buffer + 10),
>> +			*(buffer + 11),
>> +			*(buffer + 12),
>> +			*(buffer + 13),
>> +			*(buffer + 14),
>> +			*(buffer + 15));
>> +
>> +	kfree(a1);
>> +	kfree(a2);
>> +	kfree(a3);
>> +	return 0;
>> +}
>> +static efi_status_t powerpc_get_next_variable(unsigned long *name_size,
>> +					      efi_char16_t *name,
>> +					      efi_guid_t *vendor)
>> +{
>> +	int rc;
>> +	u8 *key;
>> +	int namesize;
>> +	unsigned long keylen;
>> +	unsigned long keysize = 1024;
>> +	unsigned long *mdsize;
>> +	u8 *mdata = NULL;
>> +	efi_guid_t guid;
>> +
>> +	if (ucs2_strnlen(name, 1024) > 0) {
>> +		createkey(name, &key, &keylen);
>> +	} else {
>> +		keylen = 0;
>> +		key = kzalloc(1024, GFP_KERNEL);
>> +	}
>> +
>> +	pr_info("%s: powerpc get next variable, key is %s\n", __func__, key);
> Don't put debugging info like this in the kernel log of everyone :(
>
>> +
>> +	rc = opal_get_next_variable(key, &keylen, keysize);
>> +	if (rc) {
>> +		kfree(key);
>> +		return opal_to_efi_status(rc);
>> +	}
>> +
>> +	mdsize = kzalloc(sizeof(unsigned long), GFP_KERNEL);
> No error checking?
>
>> +	rc = opal_get_variable_size(key, keylen, mdsize, NULL);
>> +	if (rc)
>> +		goto out;
>> +
>> +	if (*mdsize <= 0)
>> +		goto out;
>> +
>> +	mdata = kzalloc(*mdsize, GFP_KERNEL);
>> +
>> +	rc = opal_get_variable(key, keylen, mdata, mdsize, NULL, NULL);
>> +	if (rc)
>> +		goto out;
>> +
>> +	if (*mdsize > 0) {
>> +		namesize = *mdsize - sizeof(efi_guid_t) - sizeof(u32);
>> +		if (namesize > 0) {
>> +			memset(&guid, 0, sizeof(efi_guid_t));
>> +			convert_buffer_to_efi_guid(mdata + namesize, &guid);
>> +			memcpy(vendor, &guid, sizeof(efi_guid_t));
>> +			memset(name, 0, namesize + 2);
>> +			memcpy(name, mdata, namesize);
>> +			*name_size = namesize + 2;
>> +			name[namesize++] = 0;
>> +			name[namesize] = 0;
>> +		}
>> +	}
>> +
>> +out:
>> +	kfree(mdsize);
>> +	kfree(mdata);
>> +
>> +	return opal_to_efi_status(rc);
>> +}
>> +
>> +static efi_status_t powerpc_set_variable(efi_char16_t *name, efi_guid_t *vendor,
>> +					 u32 attr, unsigned long data_size,
>> +					 void *data)
>> +{
>> +	int rc;
>> +	u8 *key;
>> +	unsigned long keylen;
>> +	u8 *metadata;
>> +	unsigned long mdsize;
>> +
>> +	if (!name)
>> +		return EFI_INVALID_PARAMETER;
>> +
>> +	if (!vendor)
>> +		return EFI_INVALID_PARAMETER;
>> +
>> +	createkey(name, &key, &keylen);
>> +	pr_info("%s: nayna key is %s\n", __func__, key);
> Again, please remove all of your debugging code when resending.
>
>> +
>> +	createmetadata(name, vendor, &attr, &metadata, &mdsize);
>> +
>> +	rc = opal_set_variable(key, keylen, metadata, mdsize, data, data_size);
>> +
>> +	return opal_to_efi_status(rc);
>> +}
>> +
>> +
>> +static const struct efivar_operations efivar_ops = {
>> +	.get_variable = powerpc_get_variable,
>> +	.set_variable = powerpc_set_variable,
>> +	.get_next_variable = powerpc_get_next_variable,
>> +};
>> +
>> +
>> +static __init int power_secvar_init(void)
>> +{
>> +	int rc = 0;
>> +	unsigned long ver = 0;
>> +
>> +	rc = opal_variable_version(&ver);
>> +	if (ver != BACKEND_TC_COMPAT_V1) {
>> +		pr_info("Compatible backend unsupported\n");
>> +		return -1;
> Do not make up error numbers, use the defined values please.

Thanks Greg for the review !!

I will address everything in the next version.

Thanks & Regards,
         - Nayna
