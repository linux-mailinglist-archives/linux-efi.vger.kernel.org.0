Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3180117893
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2019 22:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLIVhY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 Dec 2019 16:37:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726483AbfLIVhY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 9 Dec 2019 16:37:24 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9LbLfo015064
        for <linux-efi@vger.kernel.org>; Mon, 9 Dec 2019 16:37:23 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wsu3neefw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Mon, 09 Dec 2019 16:37:22 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 9 Dec 2019 21:37:04 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Dec 2019 21:37:00 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB9Lawl152625544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Dec 2019 21:36:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9511A42042;
        Mon,  9 Dec 2019 21:36:58 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D2784203F;
        Mon,  9 Dec 2019 21:36:57 +0000 (GMT)
Received: from dhcp-9-31-102-17.watson.ibm.com (unknown [9.31.102.17])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Dec 2019 21:36:57 +0000 (GMT)
Subject: Re: [PATCH v10 0/9] powerpc: Enabling IMA arch specific secure boot
 policies
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Eric Ricther <erichte@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nayna Jain <nayna@linux.ibm.com>
Date:   Mon, 09 Dec 2019 16:36:56 -0500
In-Reply-To: <5254346f-4ba7-c820-e127-d46b84f2e6e6@linux.microsoft.com>
References: <1572492694-6520-1-git-send-email-zohar@linux.ibm.com>
         <5254346f-4ba7-c820-e127-d46b84f2e6e6@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19120921-4275-0000-0000-0000038D66CB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120921-4276-0000-0000-000038A115A8
Message-Id: <1575927416.4557.25.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_04:2019-12-09,2019-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 mlxlogscore=943 mlxscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912090170
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2019-12-09 at 12:27 -0800, Lakshmi Ramasubramanian wrote:
> Hi Mimi,
> 
> On 10/30/2019 8:31 PM, Mimi Zohar wrote:
> 
> > This patchset extends the previous version[1] by adding support for
> > checking against a blacklist of binary hashes.
> > 
> > The IMA subsystem supports custom, built-in, arch-specific policies to
> > define the files to be measured and appraised. These policies are honored
> > based on priority, where arch-specific policy is the highest and custom
> > is the lowest.
> 
> Has this change been signed off and merged for the next update of the 
> kernel (v5.5)?

Yes, refer to the linuxppc mailing list archives.

Mimi

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/

