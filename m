Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA9A28C409
	for <lists+linux-efi@lfdr.de>; Mon, 12 Oct 2020 23:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgJLV3I (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Oct 2020 17:29:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726348AbgJLV3H (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 12 Oct 2020 17:29:07 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CL2xIg022438;
        Mon, 12 Oct 2020 17:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=4enHcE4vbgBGCWLngJ8rd7FxGmMz5CJ7+9yWXSOFcj8=;
 b=O/GDDJscpc26ZAM41xgGQ/bIRG5jawTpDnXUbsYQNoAtevWpPg6PbiaRHcvglYilFcfp
 iMRHKxcnjUza2Qzcr0WJEKtpwIvNLhxBUv8pb2L+MGaQKRnGeqpUHCEJ/sCVJzHUjsJ0
 qYnUrfc2nJR1pw+NwSu2HgE5EBnQbrQG6MXORO1dD89mWlwzF0dgggTIQfewSdusKnFo
 VpKLiCZkmbpHyyCqaxdmRlCvH2fwfksh5yEC5Y2mN2a1jWGeHeOvJ1TNE0Pp+h1HFK9+
 9Gmkb1Psv5mizkUlJxnBhmczFm5GDWzg8zZoAeCcBooQIMBMtS0+g5hDvDbAmZ/qYupe Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 344xhk8typ-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 17:28:50 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09CL37e4023637;
        Mon, 12 Oct 2020 17:28:50 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 344xhk8ty0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 17:28:50 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09CLDOCW010703;
        Mon, 12 Oct 2020 21:28:48 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 34347gtdsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 21:28:47 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09CLSjO235783130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 21:28:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE1BCA4040;
        Mon, 12 Oct 2020 21:28:45 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67507A4051;
        Mon, 12 Oct 2020 21:28:44 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.17.200])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Oct 2020 21:28:44 +0000 (GMT)
Message-ID: <bafaaab0a1798b1be3f3e52f3340937edb3d84e6.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: defer arch_ima_get_secureboot() call to IMA init
 time
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, Chester Lin <clin@suse.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Date:   Mon, 12 Oct 2020 17:28:43 -0400
In-Reply-To: <20201012083631.12724-1-ardb@kernel.org>
References: <20201012083631.12724-1-ardb@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_17:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1011 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120158
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Mon, 2020-10-12 at 10:36 +0200, Ard Biesheuvel wrote:
> Chester reports that it is necessary to introduce a new way to pass
> the EFI secure boot status between the EFI stub and the core kernel
> on ARM systems. The usual way of obtaining this information is by
> checking the SecureBoot and SetupMode EFI variables, but this can
> only be done after the EFI variable workqueue is created, which
> occurs in a subsys_initcall(), whereas arch_ima_get_secureboot()
> is called much earlier by the IMA framework.
> 
> However, the IMA framework itself is started as a late_initcall,
> and the only reason the call to arch_ima_get_secureboot() occurs
> so early is because it happens in the context of a __setup()
> callback that parses the ima_appraise= command line parameter.
> 
> So let's refactor this code a little bit, by using a core_param()
> callback to capture the command line argument, and deferring any
> reasoning based on its contents to the IMA init routine.

Other than this patch needing to be on top of commit e4d7e2df3a09
("ima: limit secure boot feedback scope for appraise"), it looks good.

thanks,

Mimi

