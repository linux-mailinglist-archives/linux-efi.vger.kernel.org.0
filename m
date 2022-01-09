Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94B1488751
	for <lists+linux-efi@lfdr.de>; Sun,  9 Jan 2022 02:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiAIBsD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 8 Jan 2022 20:48:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231803AbiAIBsD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 8 Jan 2022 20:48:03 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 209126Ku014139;
        Sun, 9 Jan 2022 01:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=OZR+ah/EEcHp0R5Lc27Qcjl4B+yDvahQO8yI+JoAnaY=;
 b=CaJKfgJoNxcxjdSBCN/yA+6gCE5OoxksgVVBRk8FRDpwf3Apy5AQmtOu1GTgmpsSwayi
 uZ66G5c8YkPKL/XcpfUZZGvF/PMOKxuHHrNkD5uiEnGa0cwzKjn0XwPeKhgBX0fbCYz6
 hX/zbZf8cEhlg6FMLs6sPwCTvmm46duOrcC3mDBN56bn7rPHBRpmqGJp8L6wh/6imZkf
 kPCNtW6rs42HbNhc1oMSNS/QHuo61hXMO9xv9+gEjmy3c6SEjna1It1iwcrZtYgbQSPZ
 hye0EBvneOQFlMhcni6zMhipDSWNjOmXP/miQWQDlM8sU4llE7FEUy8iwA7ODhbMDIqy ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dfmpm10c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jan 2022 01:47:29 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2091lTGo012003;
        Sun, 9 Jan 2022 01:47:29 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dfmpm10be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jan 2022 01:47:29 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2091lPVr026565;
        Sun, 9 Jan 2022 01:47:26 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3df1vhunaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jan 2022 01:47:26 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2091lOn430802382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 9 Jan 2022 01:47:24 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BDEE11C050;
        Sun,  9 Jan 2022 01:47:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CA5011C04C;
        Sun,  9 Jan 2022 01:47:22 +0000 (GMT)
Received: from sig-9-65-90-30.ibm.com (unknown [9.65.90.30])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  9 Jan 2022 01:47:22 +0000 (GMT)
Message-ID: <2aa9e4b290424c869afe983ed63b5a0c4d12df36.camel@linux.ibm.com>
Subject: Re: [PATCH v9 8/8] integrity: Only use machine keyring when
 uefi_check_trust_mok_keys is true
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org, ardb@kernel.org,
        jmorris@namei.org, serge@hallyn.com, nayna@linux.ibm.com,
        keescook@chromium.org, torvalds@linux-foundation.org,
        weiyongjun1@huawei.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Date:   Sat, 08 Jan 2022 20:47:21 -0500
In-Reply-To: <YdoQbKD/jJompy6I@iki.fi>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
         <20220105235012.2497118-9-eric.snowberg@oracle.com>
         <YdoQbKD/jJompy6I@iki.fi>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9oUeFJysa5sv7YWHrbFnSWMq5XgGhiSC
X-Proofpoint-ORIG-GUID: 5zwOrCfCPgD-ovmE2lzA6sA08F2T0i_0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-08_09,2022-01-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 impostorscore=0 mlxscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201090008
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 2022-01-09 at 00:30 +0200, Jarkko Sakkinen wrote:
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Mimi, have you tested these patches already?

Sorry, not yet this version this of the patch set.  Planning to test
shortly.

Mimi

