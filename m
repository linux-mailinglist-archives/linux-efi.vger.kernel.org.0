Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3318DDA17
	for <lists+linux-efi@lfdr.de>; Sat, 19 Oct 2019 20:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfJSSa7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 19 Oct 2019 14:30:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726078AbfJSSa7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 19 Oct 2019 14:30:59 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9JIRW1G029373;
        Sat, 19 Oct 2019 14:30:40 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vr7mug9xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Oct 2019 14:30:40 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9JITtKR033176;
        Sat, 19 Oct 2019 14:30:39 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vr7mug9x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Oct 2019 14:30:39 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9JIUc4O003199;
        Sat, 19 Oct 2019 18:30:38 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01dal.us.ibm.com with ESMTP id 2vqt45p0jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Oct 2019 18:30:38 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9JIUal554591794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Oct 2019 18:30:36 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8AA413604F;
        Sat, 19 Oct 2019 18:30:36 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 208D4136051;
        Sat, 19 Oct 2019 18:30:34 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.146.216])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat, 19 Oct 2019 18:30:33 +0000 (GMT)
Subject: Re: [PATCH v7 7/8] ima: check against blacklisted hashes for files
 with modsig
To:     Mimi Zohar <zohar@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>,
        linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>
References: <1570497267-13672-1-git-send-email-nayna@linux.ibm.com>
 <1570497267-13672-8-git-send-email-nayna@linux.ibm.com>
 <1570799995.5250.81.camel@linux.ibm.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <b482896c-6d40-ad77-fc61-e66c21b83103@linux.vnet.ibm.com>
Date:   Sat, 19 Oct 2019 14:30:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1570799995.5250.81.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910190172
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Mimi,


On 10/11/2019 09:19 AM, Mimi Zohar wrote:
> On Mon, 2019-10-07 at 21:14 -0400, Nayna Jain wrote:
>> Asymmetric private keys are used to sign multiple files. The kernel
>> currently support checking against the blacklisted keys. However, if the
>> public key is blacklisted, any file signed by the blacklisted key will
>> automatically fail signature verification. We might not want to blacklist
>> all the files signed by a particular key, but just a single file.
>> Blacklisting the public key is not fine enough granularity.
>>
>> This patch adds support for blacklisting binaries with appended signatures,
>> based on the IMA policy.  Defined is a new policy option
>> "appraise_flag=check_blacklist".
> The blacklisted hash is not the same as the file hash, but is the file
> hash without the appended signature.  Are there tools for calculating
> the blacklisted hash?  Can you provide an example?

I have updated the patch description to specify that the blacklisted 
hash is the file hash without the appended signature. I hope that makes 
it clear now.

Thanks & Regards,
     - Nayna
