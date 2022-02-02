Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B184A6F9F
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 12:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiBBLJE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 06:09:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4882 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229552AbiBBLJD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Feb 2022 06:09:03 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2129iXmA029912;
        Wed, 2 Feb 2022 11:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=shvqkXvwBGhCyz2qik8cJc1xSKVf3VVPJ4yH2QFiU9g=;
 b=Hp5eZdMhMkIFaFaEf2Nfk6s/iaZlR15K+fbqt2u3KuFJPxwKO1ursKyIMflbBAwD8brB
 wlB/6bhB2IN2xIR62b6i2Q436nrBpNjA3ybOrD+1j6LCnD8osJkfHzD32BlV7XSPfoFG
 Ne4VOu0+k4MiNvaPFKfQvbRbDeGQr+ysZbAYGnCutp91OxKtf1MdmuLwOlDh77Zk4ph3
 ddGnT0jZdkRSl6dXnZ0iXJX6oQrXyVOUw7eLiqeSs4m6dk2o+IojGGGRDd3j/9Z1U7iE
 sASE0fE5og9aed+BD1NMYKc3e519kU+YkXWr4mM96ufn+6bQUkMGCctV8yKkJYEGJg0M /g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dyqkfshsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 11:08:51 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 212AVu1i012260;
        Wed, 2 Feb 2022 11:08:50 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dyqkfshse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 11:08:50 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 212B33HD021296;
        Wed, 2 Feb 2022 11:08:50 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04wdc.us.ibm.com with ESMTP id 3dvw7aubhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 11:08:50 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 212B8nC028180792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Feb 2022 11:08:49 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B43C2805E;
        Wed,  2 Feb 2022 11:08:49 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB86C28076;
        Wed,  2 Feb 2022 11:08:44 +0000 (GMT)
Received: from [9.65.240.79] (unknown [9.65.240.79])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Feb 2022 11:08:44 +0000 (GMT)
Message-ID: <c7604c39-d6ca-f3b9-b1d8-fd0362216717@linux.ibm.com>
Date:   Wed, 2 Feb 2022 13:08:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v7 4/5] efi: Load efi_secret module if EFI secret area is
 populated
Content-Language: en-US
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
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
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <20220201124413.1093099-5-dovmurik@linux.ibm.com>
 <20220202084723.ushasiekb3cxami4@sirius.home.kraxel.org>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <20220202084723.ushasiekb3cxami4@sirius.home.kraxel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NPJ6cJxQKUaWnVHY156ex6KRRnLxgFMB
X-Proofpoint-GUID: gJAHBmK6bH8JMAj3_AEoP7iKADGz6PuZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_05,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020059
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 02/02/2022 10:47, Gerd Hoffmann wrote:
> On Tue, Feb 01, 2022 at 12:44:12PM +0000, Dov Murik wrote:
>> If the efi_secret module is built, register a late_initcall in the EFI
>> driver which checks whether the EFI secret area is available and
>> populated, and then requests to load the efi_secret module.
> 
>> +	area = memremap(efi.coco_secret, sizeof(*area), MEMREMAP_WB);
>> +	if (!area) {
>> +		pr_err("Failed to map confidential computing secret area descriptor\n");
>> +		return -ENOMEM;
>> +	}
>> +	if (!area->base_pa || area->size < sizeof(*header_guid))
>> +		goto unmap_desc;
>> +
>> +	header_guid = (void __force *)ioremap_encrypted(area->base_pa, sizeof(*header_guid));
>> +	if (!header_guid) {
>> +		pr_err("Failed to map secret area\n");
>> +		ret = -ENOMEM;
>> +		goto unmap_desc;
>> +	}
>> +	if (efi_guidcmp(*header_guid, EFI_SECRET_TABLE_HEADER_GUID))
>> +		goto unmap_encrypted;
> 
> Why these sanity checks are here and not in the efi_secret module?
> 

The same checks indeed appear in the efi_secret module (see in patch 3:
efi_secret_map_area() and the beginning of efi_secret_securityfs_setup()).

However, in the efi_secret module, the checks are noisy, because they
expect the secret area to be populated.  For example:

+	if (efi.coco_secret == EFI_INVALID_TABLE_ADDR) {
+		pr_err("Secret area address is not available\n");
+		return -EINVAL;
+	}
...
+	if (efi_guidcmp(h->guid, EFI_SECRET_TABLE_HEADER_GUID)) {
+		pr_err("EFI secret area does not start with correct GUID\n");
+		ret = -EINVAL;
+		goto err_cleanup;
+	}
...


Whereas here (patch 4, in efi/coco.c) the EFI driver checks if there a
populated secret area, and if there is one, triggers the efi_secret
module load.


Another approach could be to just try to load the module anyway, and the
module will fail (silently? noisily?) if there's no designated secret area
or it's not populated.  I feel that will be harder to understand what's going on.


I'm open to suggestions in case this duplication is too bad (maybe efi_secret
can expose some kind of probe() function that can be called before actually
initializing it?)


Thanks,
-Dov
