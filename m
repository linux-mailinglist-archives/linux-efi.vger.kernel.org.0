Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D6825A02D
	for <lists+linux-efi@lfdr.de>; Tue,  1 Sep 2020 22:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgIAUtO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Sep 2020 16:49:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726091AbgIAUtN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Sep 2020 16:49:13 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 081KmciW110668;
        Tue, 1 Sep 2020 16:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=LriRH46lQxUd0tQXUZHWmDgdjSCZ34A+0AfqPQWnviM=;
 b=Mf03Kg00Kj9NmYoTGbjLMDn+i+R/6RHxZ847xmMb4iNDEZY7YXXL2e7+lnegXgRnl1Og
 9SMCfrULSHKE+5QQoXan+Uo61VnvVbfYWa/H6UY/nrDmxS22UgovN9vQnuk3FlXLsz6k
 Hac1uuOOaK+daEA1+CrhncWLMUTMY4jhPJdL6qvro6KCuhrRjNfIYyybbTjHourKCPvc
 5d535RDUCDPv6BdZtDdAtY+QpJWmlcCucR5n87rD7z5jlt3vesUzNdf9qCKE3bBlLSxX
 syaFfTJ1+Tx/dxvhE3oHmaAe8hYTk2JJwLt54nWz22FvRdHhw3YVC7ec/t3Mp9a1j5oy Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 339wnrr03u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 16:48:58 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 081KmwQF111445;
        Tue, 1 Sep 2020 16:48:58 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 339wnrr03h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 16:48:58 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 081KksPW004529;
        Tue, 1 Sep 2020 20:48:56 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 337en82dpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 20:48:56 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 081Kms0127394346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Sep 2020 20:48:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 449C34203F;
        Tue,  1 Sep 2020 20:48:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3990542041;
        Tue,  1 Sep 2020 20:48:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.77.139])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Sep 2020 20:48:51 +0000 (GMT)
Message-ID: <4190d5a54590e16a7612f132c6013f3310f99571.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] integrity: Move import of MokListRT certs to a
 separate routine
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lenny Szubowicz <lszubowi@redhat.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, ardb@kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        bp@alien8.de, pjones@redhat.com, dhowells@redhat.com,
        prarit@redhat.com
Date:   Tue, 01 Sep 2020 16:48:50 -0400
In-Reply-To: <20200826034455.28707-3-lszubowi@redhat.com>
References: <20200826034455.28707-1-lszubowi@redhat.com>
         <20200826034455.28707-3-lszubowi@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-01_10:2020-09-01,2020-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010170
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2020-08-25 at 23:44 -0400, Lenny Szubowicz wrote:
> Move the loading of certs from the UEFI MokListRT into a separate
> routine to facilitate additional MokList functionality.
> 
> There is no visible functional change as a result of this patch.
> Although the UEFI dbx certs are now loaded before the MokList certs,
> they are loaded onto different key rings. So the order of the keys
> on their respective key rings is the same.
> 
> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

