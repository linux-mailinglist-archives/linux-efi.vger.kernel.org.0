Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20ECD252D16
	for <lists+linux-efi@lfdr.de>; Wed, 26 Aug 2020 13:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgHZLzk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Aug 2020 07:55:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729184AbgHZLzj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Aug 2020 07:55:39 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07QBXJ7x021628;
        Wed, 26 Aug 2020 07:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=dHqlfOWSxjq+gaqjLFymI8135q9+O5+SFhB0cL1SeAg=;
 b=Ufg/BlL2bIQ4Z8Vs2bqLdfnFjNZRXOHuBIuvqOuxdB/L4XCegNlA+4KQuAat81knZc6v
 Xri75XdYAgIZTq5jBONqlcU2BPV8cggLx/F4OaG8lX12H6aNLaWrieeAGknTuGTiW43Z
 VWWJGAsOk0FVBryUHK649HimsSX/qkKY5SUMgwMz48t3EJzYSrwP5YDIBkr2qEgqMDwn
 lJ7WN1lEpnCyMHYzwh1c1ZbQ40k11fDV7Pj7RvIJrqZTJ+3w/KFj+8jAUS0EMi0hWRo8
 GkzT2UEap8iufCWz2cWHLZ0T3Ix5Tt5KoAXJ5RQ4Rf7187Rx8/tlebLr77O8A2tnNPDf rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 335pfn9gn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 07:55:20 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07QBYHm3025194;
        Wed, 26 Aug 2020 07:55:19 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 335pfn9gm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 07:55:19 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07QBr8Ul003672;
        Wed, 26 Aug 2020 11:55:17 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 332utq2rkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 11:55:16 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07QBtENT26476832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 11:55:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A07352057;
        Wed, 26 Aug 2020 11:55:14 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.28.3])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A618A52050;
        Wed, 26 Aug 2020 11:55:11 +0000 (GMT)
Message-ID: <6f63a0cf1349281ef2c407d95abedfba1f90345a.camel@linux.ibm.com>
Subject: Re: [PATCH 0/3] integrity: Load certs from EFI MOK config table
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lenny Szubowicz <lszubowi@redhat.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, ardb@kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        bp@alien8.de, pjones@redhat.com, dhowells@redhat.com,
        prarit@redhat.com
Date:   Wed, 26 Aug 2020 07:55:10 -0400
In-Reply-To: <20200826034455.28707-1-lszubowi@redhat.com>
References: <20200826034455.28707-1-lszubowi@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_08:2020-08-26,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260094
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Lenny,

On Tue, 2020-08-25 at 23:44 -0400, Lenny Szubowicz wrote:
> Because of system-specific EFI firmware limitations,
> EFI volatile variables may not be capable of holding the
> required contents of the Machine Owner Key (MOK) certificate
> store. Therefore, an EFI boot loader may pass the MOK certs
> via a EFI configuration table created specifically for this
> purpose to avoid this firmware limitation.
> 
> An EFI configuration table is a simpler and more robust mechanism
> compared to EFI variables and is well suited for one-way passage
> of static information from a pre-OS environment to the kernel.
> 
> This patch set does not remove the support for loading certs
> from the EFI MOK variables into the platform key ring.
> However, if both the EFI MOK config table and corresponding
> EFI MOK variables are present, the MOK table is used as the
> source of MOK certs.
> 
> The contents of the individual named MOK config table entries are
> made available to user space via read-only sysfs binary files under:
> 
> 	/sys/firmware/efi/mok-variables/

Please include a security section in this cover letter with a
comparison of the MoK variables and the EFI configuration table
security (eg. same mechanism?).  Has mokutil been updated?  If so,
please provide a link.

Mimi

