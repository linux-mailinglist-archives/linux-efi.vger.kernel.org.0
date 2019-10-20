Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3C42DDF60
	for <lists+linux-efi@lfdr.de>; Sun, 20 Oct 2019 18:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfJTQGy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 20 Oct 2019 12:06:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726492AbfJTQGx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 20 Oct 2019 12:06:53 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9KG299p101211
        for <linux-efi@vger.kernel.org>; Sun, 20 Oct 2019 12:06:52 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vrs0a26wj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Sun, 20 Oct 2019 12:06:52 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 20 Oct 2019 17:06:50 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 20 Oct 2019 17:06:47 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9KG6ja959637802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 20 Oct 2019 16:06:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D7134C046;
        Sun, 20 Oct 2019 16:06:45 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 458B34C05A;
        Sun, 20 Oct 2019 16:06:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.142.191])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 20 Oct 2019 16:06:43 +0000 (GMT)
Subject: Re: [PATCH v8 7/8] ima: check against blacklisted hashes for files
 with modsig
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
Date:   Sun, 20 Oct 2019 12:06:42 -0400
In-Reply-To: <1571508377-23603-8-git-send-email-nayna@linux.ibm.com>
References: <1571508377-23603-1-git-send-email-nayna@linux.ibm.com>
         <1571508377-23603-8-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102016-4275-0000-0000-000003748980
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102016-4276-0000-0000-00003887A7C6
Message-Id: <1571587602.5104.8.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=968 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910200162
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 2019-10-19 at 14:06 -0400, Nayna Jain wrote:
> Asymmetric private keys are used to sign multiple files. The kernel
> currently support checking against blacklisted keys. However, if the
> public key is blacklisted, any file signed by the blacklisted key will
> automatically fail signature verification. We might not want to blacklist
> all the files signed by a particular key, but just a single file.
> Blacklisting the public key is not fine enough granularity.
> 
> This patch adds support for checking against the blacklisted hash of the
> file based on the IMA policy. The blacklisted hash is the file hash
> without the appended signature. Defined is a new policy option
> "appraise_flag=check_blacklist".

Please add an example of how to blacklist a file with an appended
signature.  The simplest example that works on x86 as well as Power
would be blacklisting a kernel module.  The example should include
calculating the kernel module hash without the appended signature,
enabling the Kconfig option (CONFIG_SYSTEM_BLACKLIST_HASH_LIST), and
the blacklist hash format (eg. "bin:<file hash>").

thanks, 

Mimi

