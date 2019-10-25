Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDA0E51DB
	for <lists+linux-efi@lfdr.de>; Fri, 25 Oct 2019 19:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393891AbfJYRCe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Oct 2019 13:02:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726511AbfJYRCe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 25 Oct 2019 13:02:34 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PGuiXf029285;
        Fri, 25 Oct 2019 13:02:17 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vv42u28q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Oct 2019 13:02:16 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9PGxFGo035516;
        Fri, 25 Oct 2019 13:02:16 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vv42u28pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Oct 2019 13:02:16 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9PH1SHd031917;
        Fri, 25 Oct 2019 17:02:14 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 2vqt47sxx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Oct 2019 17:02:14 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9PH2Dma33554838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 17:02:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C959B2065;
        Fri, 25 Oct 2019 17:02:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F5B0B2066;
        Fri, 25 Oct 2019 17:02:12 +0000 (GMT)
Received: from [9.85.155.79] (unknown [9.85.155.79])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 25 Oct 2019 17:02:12 +0000 (GMT)
Subject: Re: [PATCH v9 2/8] powerpc/ima: add support to initialize ima policy
 rules
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Prakhar Srivastava <prsriva02@gmail.com>
References: <20191024034717.70552-1-nayna@linux.ibm.com>
 <20191024034717.70552-3-nayna@linux.ibm.com>
 <dd7e04fc-25e8-280f-b565-bdb031939655@linux.microsoft.com>
From:   Nayna Jain <nayna@linux.vnet.ibm.com>
Message-ID: <27dbe08e-5473-4dd0-d2ad-2df591e23f5e@linux.vnet.ibm.com>
Date:   Fri, 25 Oct 2019 12:02:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <dd7e04fc-25e8-280f-b565-bdb031939655@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250156
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 10/24/19 12:35 PM, Lakshmi Ramasubramanian wrote:
> On 10/23/2019 8:47 PM, Nayna Jain wrote:
>
>> +/*
>> + * The "secure_rules" are enabled only on "secureboot" enabled systems.
>> + * These rules verify the file signatures against known good values.
>> + * The "appraise_type=imasig|modsig" option allows the known good 
>> signature
>> + * to be stored as an xattr or as an appended signature.
>> + *
>> + * To avoid duplicate signature verification as much as possible, 
>> the IMA
>> + * policy rule for module appraisal is added only if 
>> CONFIG_MODULE_SIG_FORCE
>> + * is not enabled.
>> + */
>> +static const char *const secure_rules[] = {
>> +    "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
>> +#ifndef CONFIG_MODULE_SIG_FORCE
>> +    "appraise func=MODULE_CHECK appraise_type=imasig|modsig",
>> +#endif
>> +    NULL
>> +};
>
> Is there any way to not use conditional compilation in the above array 
> definition? Maybe define different functions to get "secure_rules" for 
> when CONFIG_MODULE_SIG_FORCE is defined and when it is not defined.

How will you decide which function to be called ?

Thanks & Regards,

     - Nayna

