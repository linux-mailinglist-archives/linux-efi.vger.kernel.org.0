Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0999C2A50A5
	for <lists+linux-efi@lfdr.de>; Tue,  3 Nov 2020 21:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgKCUDh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Nov 2020 15:03:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727688AbgKCUDh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Nov 2020 15:03:37 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3K2x5O184970;
        Tue, 3 Nov 2020 15:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=8FVQINE+bcKvDVL9N41N7knor54BJiq6qPUipkFnb4g=;
 b=hm4q/D0tGANPl8WKan/+nywwpKvAF1GL7/YbTKafg9fFnOgkaa1PhvBmMVpe1wNuizVw
 74rNZGN8rZQ+GTqxVmu8AziHlBBMEma6KPNguZdZS+AGssdLPYSy+fioGxXzlpoYCINq
 fHB56Qm7Qvti+79sjMGmUY3LZzHI8IrlG/eIWUC+WPIojIsatZm+amT60K2j/87WRf2i
 xNHbmJAa9pQq3D24ao4/aBVo6pH6xQmlYZ7uAwUfzdhLdsIwWFKrZhqwxhC8yKfBPht0
 1yyBHMhVrByZQXIMkFP8jUxbQUFREWj5tlWyyQcJvOPKq3gffmjRtIeVJlrx6hM+lsZc IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34kdmqre7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 15:03:17 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A3K356B185937;
        Tue, 3 Nov 2020 15:03:17 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34kdmqre5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 15:03:16 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A3JvvuN004503;
        Tue, 3 Nov 2020 20:03:14 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 34h01khuex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 20:03:14 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A3K3BOq6488642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Nov 2020 20:03:11 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC79B11C04A;
        Tue,  3 Nov 2020 20:03:11 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C58211C050;
        Tue,  3 Nov 2020 20:03:09 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.125.87])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Nov 2020 20:03:09 +0000 (GMT)
Message-ID: <3d8e2997ea1a87a91d35dbcb5e5c5faea0349f70.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/3] efi: generalize efi_get_secureboot
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Chester Lin <clin@suse.com>,
        X86 ML <x86@kernel.org>, "Lee, Chun-Yi" <jlee@suse.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 03 Nov 2020 15:03:08 -0500
In-Reply-To: <CAMj1kXHQe46CuGSna8+EJw6MGq1keLbcuit16LfJbKGnfnAN6g@mail.gmail.com>
References: <20201102223800.12181-1-ardb@kernel.org>
         <20201102223800.12181-2-ardb@kernel.org>
         <93e614b138c9f047612db304ca5ebe8a7b21c941.camel@linux.ibm.com>
         <CAMj1kXHQe46CuGSna8+EJw6MGq1keLbcuit16LfJbKGnfnAN6g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_08:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxlogscore=820 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030131
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2020-11-03 at 20:01 +0100, Ard Biesheuvel wrote:
> > get_var() should be defined as "efi_status_t".   If this is being
> > upstreamed via integrity, I can make the change.
> >
> 
> No, get_var is a pointer to a function returning efi_status_t, check
> include/linux/efi.h for details.

Got it.

thanks,

Mimi


