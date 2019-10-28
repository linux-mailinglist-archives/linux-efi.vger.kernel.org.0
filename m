Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A671E7111
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2019 13:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388699AbfJ1MLe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Oct 2019 08:11:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58546 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388834AbfJ1MK4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Oct 2019 08:10:56 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9SC49Pe084297
        for <linux-efi@vger.kernel.org>; Mon, 28 Oct 2019 08:10:55 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vvgy370sd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Mon, 28 Oct 2019 08:10:55 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 28 Oct 2019 12:10:53 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 28 Oct 2019 12:10:48 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9SCAkZb50135174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 12:10:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 522B5A4051;
        Mon, 28 Oct 2019 12:10:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDF40A404D;
        Mon, 28 Oct 2019 12:10:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.151.87])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Oct 2019 12:10:43 +0000 (GMT)
Subject: Re: [PATCH v9 0/8] powerpc: Enabling IMA arch specific secure boot
 policies
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
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
        "Oliver O'Halloran" <oohall@gmail.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date:   Mon, 28 Oct 2019 08:10:43 -0400
In-Reply-To: <20191024034717.70552-1-nayna@linux.ibm.com>
References: <20191024034717.70552-1-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102812-4275-0000-0000-000003786D27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102812-4276-0000-0000-0000388B9F9F
Message-Id: <1572264643.4532.244.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-28_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=860 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910280124
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2019-10-23 at 22:47 -0500, Nayna Jain wrote:
> This patchset extends the previous version[1] by adding support for
> checking against a blacklist of binary hashes.
> 
> The IMA subsystem supports custom, built-in, arch-specific policies to
> define the files to be measured and appraised. These policies are honored
> based on priority, where arch-specific policy is the highest and custom
> is the lowest.
> 
> PowerNV system uses a Linux-based bootloader to kexec the OS. The
> bootloader kernel relies on IMA for signature verification of the OS
> kernel before doing the kexec. This patchset adds support for powerpc
> arch-specific IMA policies that are conditionally defined based on a
> system's secure boot and trusted boot states. The OS secure boot and
> trusted boot states are determined via device-tree properties.
> 
> The verification needs to be performed only for binaries that are not
> blacklisted. The kernel currently only checks against the blacklist of
> keys. However, doing so results in blacklisting all the binaries that
> are signed by the same key. In order to prevent just one particular
> binary from being loaded, it must be checked against a blacklist of
> binary hashes. This patchset also adds support to IMA for checking
> against a hash blacklist for files. signed by appended signature.
> 
> [1] http://patchwork.ozlabs.org/cover/1149262/ 

Thanks, Nayna.

Please feel free to add my Signed-off-by tag on patches (2, 4, 5, 7 &
8).

thanks,

Mimi

