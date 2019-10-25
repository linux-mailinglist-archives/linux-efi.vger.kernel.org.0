Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4055DE5190
	for <lists+linux-efi@lfdr.de>; Fri, 25 Oct 2019 18:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409511AbfJYQuK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Oct 2019 12:50:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29930 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502383AbfJYQuI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 25 Oct 2019 12:50:08 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PGgK16075467;
        Fri, 25 Oct 2019 12:49:41 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vv3ck3jxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Oct 2019 12:49:40 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9PGghME076302;
        Fri, 25 Oct 2019 12:49:40 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vv3ck3jxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Oct 2019 12:49:40 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9PGj6nB008403;
        Fri, 25 Oct 2019 16:49:39 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04dal.us.ibm.com with ESMTP id 2vqt489u53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Oct 2019 16:49:39 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9PGncQR51839294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 16:49:38 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7369DB205F;
        Fri, 25 Oct 2019 16:49:38 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C168B2065;
        Fri, 25 Oct 2019 16:49:37 +0000 (GMT)
Received: from [9.85.155.79] (unknown [9.85.155.79])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 25 Oct 2019 16:49:37 +0000 (GMT)
Subject: Re: [PATCH v9 1/8] powerpc: detect the secure boot mode of the system
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
 <20191024034717.70552-2-nayna@linux.ibm.com>
 <b0282ef2-f75c-a139-9991-01eba15adb22@linux.microsoft.com>
From:   Nayna Jain <nayna@linux.vnet.ibm.com>
Message-ID: <569f401a-4327-4295-677f-48037f2582a0@linux.vnet.ibm.com>
Date:   Fri, 25 Oct 2019 11:49:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b0282ef2-f75c-a139-9991-01eba15adb22@linux.microsoft.com>
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
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250154
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 10/24/19 12:26 PM, Lakshmi Ramasubramanian wrote:
> On 10/23/2019 8:47 PM, Nayna Jain wrote:
>> This patch defines a function to detect the secure boot state of a
>> PowerNV system.
>
>> +bool is_ppc_secureboot_enabled(void)
>> +{
>> +    struct device_node *node;
>> +    bool enabled = false;
>> +
>> +    node = of_find_compatible_node(NULL, NULL, "ibm,secvar-v1");
>> +    if (!of_device_is_available(node)) {
>> +        pr_err("Cannot find secure variable node in device tree; 
>> failing to secure state\n");
>> +        goto out;
>
> Related to "goto out;" above:
>
> Would of_find_compatible_node return NULL if the given node is not found?
>
> If of_device_is_available returns false (say, because node is NULL or 
> it does not find the specified node) would it be correct to call 
> of_node_put?

of_node_put() handles NULL.

Thanks & Regards,

      - Nayna

