Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A54A89D353
	for <lists+linux-efi@lfdr.de>; Mon, 26 Aug 2019 17:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbfHZPqn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Aug 2019 11:46:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730148AbfHZPqn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Aug 2019 11:46:43 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7QFRwXM057334;
        Mon, 26 Aug 2019 11:46:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2umgym3jfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 11:46:18 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7QFSs5u061311;
        Mon, 26 Aug 2019 11:46:17 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2umgym3jfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 11:46:17 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7QFjNQo028669;
        Mon, 26 Aug 2019 15:46:16 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 2ujvv6h3r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 15:46:16 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7QFkE0h52167138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Aug 2019 15:46:14 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76D41C6057;
        Mon, 26 Aug 2019 15:46:14 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D59CC6059;
        Mon, 26 Aug 2019 15:46:11 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.199.141])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 26 Aug 2019 15:46:11 +0000 (GMT)
Subject: Re: [PATCH v3 2/4] powerpc: expose secure variables to userspace via
 sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nayna Jain <nayna@linux.ibm.com>
Cc:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>
References: <1566825818-9731-1-git-send-email-nayna@linux.ibm.com>
 <1566825818-9731-3-git-send-email-nayna@linux.ibm.com>
 <20190826145649.GA27342@kroah.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <2c5b8ba3-e5a3-5c80-a291-ea9965db2019@linux.vnet.ibm.com>
Date:   Mon, 26 Aug 2019 11:46:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190826145649.GA27342@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908260159
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 08/26/2019 10:56 AM, Greg Kroah-Hartman wrote:
> On Mon, Aug 26, 2019 at 09:23:36AM -0400, Nayna Jain wrote:
>> +static struct kobj_attribute size_attr = __ATTR_RO(size);
> Wait, why not just normal ATTR_RO()?

Oh!! Sorry. I am not seeing this macro in sysfs.h. am I missing something ?

>
>> +static struct bin_attribute data_attr = __BIN_ATTR_RO(data, VARIABLE_MAX_SIZE);
> And BIN_ATTR_RO() here?

This would have worked. I think I just thought to use the same way as 
__ATTR_RO().
I will change this to __BIN_ATTR_RO and use __BIN_ATTR_WO from your patch.

Thanks for the patch.

Thanks & Regards,
     - Nayna
