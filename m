Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5636226688E
	for <lists+linux-efi@lfdr.de>; Fri, 11 Sep 2020 21:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgIKTJC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Sep 2020 15:09:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbgIKTJA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Sep 2020 15:09:00 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BJ3pA0135511;
        Fri, 11 Sep 2020 15:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=8jEx563BrMVT+19G9TowoPShp91w2ilK5GNGgfLV120=;
 b=QZ04DitK+0lZdNOLKV7awEI4LN3LSkNHCLnMu1At/8aJqbh82+7KQwGr3goFbEapCZca
 tN298/p7BZLMsgtQujXDRl12rDi+vm92R7W2xQ5ih9REpUZOrtvqOec2harRSIVVOljT
 2M1uElWyUMJ4LYLb0qnjefUgY5qSoAV3rnuWykZ0RfZVUL1xNTuynY8Bb08jScsU5dQJ
 DmFe1h1gDSWxkxb26un54JdUdlYyBZ3N+kcXyAwlUQjIzBMkKN6TVZ4ccYkQHQXS778i
 yQ7GccvQYe2lDveKz5Rw856URwV3pphWePhnmPwPNSJKpuaZ7x632JCHpWmf3enDUxFB 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33gf2j04cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 15:08:47 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08BJ5Bu2144825;
        Fri, 11 Sep 2020 15:08:47 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33gf2j04as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 15:08:46 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BJ7FlU011806;
        Fri, 11 Sep 2020 19:08:44 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 33c2a8c97b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 19:08:43 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08BJ8feS59638190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 19:08:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B28995204E;
        Fri, 11 Sep 2020 19:08:41 +0000 (GMT)
Received: from sig-9-65-251-51.ibm.com (unknown [9.65.251.51])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E9AF25204F;
        Fri, 11 Sep 2020 19:08:38 +0000 (GMT)
Message-ID: <06ea64fec71ebd18f0c5ed6b0d9b5a7d8f1d4775.camel@linux.ibm.com>
Subject: Re: [PATCH V2 2/3] integrity: Move import of MokListRT certs to a
 separate routine
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Lenny Szubowicz <lszubowi@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, andy.shevchenko@gmail.com,
        James Morris <jmorris@namei.org>, serge@hallyn.com,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Jones <pjones@redhat.com>,
        David Howells <dhowells@redhat.com>, prarit@redhat.com
Date:   Fri, 11 Sep 2020 15:08:38 -0400
In-Reply-To: <CAMj1kXEz8y+X6KjqWWFD=38dDowqXDBvnPbgeh30+o83KpmKrg@mail.gmail.com>
References: <20200905013107.10457-1-lszubowi@redhat.com>
         <20200905013107.10457-3-lszubowi@redhat.com>
         <CAMj1kXEdkdeE8VSZqEzhd__Kb7_ZmG2af6iBpbY3=nsj1-phYw@mail.gmail.com>
         <f0a079b1-5f02-8618-fdfe-aea2278113c9@redhat.com>
         <cb8b4ebaa35d79eba65b011d042d20a991adf540.camel@linux.ibm.com>
         <394190b9-59bd-5cb3-317e-736852f190f4@redhat.com>
         <CAMj1kXEz8y+X6KjqWWFD=38dDowqXDBvnPbgeh30+o83KpmKrg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_10:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=859 adultscore=0 malwarescore=0
 suspectscore=3 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009110152
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2020-09-11 at 21:16 +0300, Ard Biesheuvel wrote:
> I think we can just merge the patches as they are, with Mimi's R-b carried over.

Other than the comments beginning on the "/*" line as opposed to the
subsequent line, the updated 2/2 and 3/3 patches look fine.

thanks,

Mimi

