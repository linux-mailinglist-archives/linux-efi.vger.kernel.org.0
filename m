Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF3BEA1DD
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2019 17:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfJ3QgI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Oct 2019 12:36:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726793AbfJ3QgH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Oct 2019 12:36:07 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9UGSYnf085893
        for <linux-efi@vger.kernel.org>; Wed, 30 Oct 2019 12:36:05 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vyc6qnrtr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Wed, 30 Oct 2019 12:36:05 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 30 Oct 2019 16:36:03 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 30 Oct 2019 16:35:57 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9UGZtxl35848306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 16:35:55 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD11AA405B;
        Wed, 30 Oct 2019 16:35:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B9C6A4054;
        Wed, 30 Oct 2019 16:35:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.134.98])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 30 Oct 2019 16:35:52 +0000 (GMT)
Subject: Re: [PATCH v9 5/8] ima: make process_buffer_measurement() generic
From:   Mimi Zohar <zohar@linux.ibm.com>
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Prakhar Srivastava <prsriva02@gmail.com>
Date:   Wed, 30 Oct 2019 12:35:52 -0400
In-Reply-To: <6c94bfc0-d3ce-202b-6927-f664ee513fa9@linux.microsoft.com>
References: <20191024034717.70552-1-nayna@linux.ibm.com>
         <20191024034717.70552-6-nayna@linux.ibm.com>
         <6c94bfc0-d3ce-202b-6927-f664ee513fa9@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19103016-0028-0000-0000-000003B12C1E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19103016-0029-0000-0000-00002473720A
Message-Id: <1572453352.5707.3.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=649 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910300149
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2019-10-30 at 08:22 -0700, Lakshmi Ramasubramanian wrote:
> On 10/23/19 8:47 PM, Nayna Jain wrote:
> 
> Hi Nayna,
> 
> > process_buffer_measurement() is limited to measuring the kexec boot
> > command line. This patch makes process_buffer_measurement() more
> > generic, allowing it to measure other types of buffer data (e.g.
> > blacklisted binary hashes or key hashes).
> 
> Now that process_buffer_measurement() is being made generic to measure 
> any buffer, it would be good to add a tag to indicate what type of 
> buffer is being measured.
> 
> For example, if the buffer is kexec command line the log could look like:
> 
>   "kexec_cmdline: <command line data>"
> 
> Similarly, if the buffer is blacklisted binary hash:
> 
>   "blacklist hash: <data>".
> 
> If the buffer is key hash:
> 
>   "<name of the keyring>: key data".
> 
> This would greatly help the consumer of the IMA log to know the type of 
> data represented in each IMA log entry.

Both the existing kexec command line and the new blacklist buffer
measurement pass that information in the eventname.   The [PATCH 7/8]
"ima: check against blacklisted hashes for files with modsig" patch
description includes an example.

Mimi

