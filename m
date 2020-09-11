Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225F92662C5
	for <lists+linux-efi@lfdr.de>; Fri, 11 Sep 2020 18:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgIKQAF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Sep 2020 12:00:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726486AbgIKP7c (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Sep 2020 11:59:32 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BFg9QW081422;
        Fri, 11 Sep 2020 11:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=uZDTO2GkQg+Od5pn1R1dGCVVyOGSxX9njGLsk+QgEdQ=;
 b=e5pnrFZuvYtzcUS40VWKTHD1wbawkwx6oagAwtmOyehwmUvsneTpPXp5ZnAXvx6D+cPm
 6cdx1Qe/OSkVof5RiEhwg8rqwCT4Qv0YQa/cwjF4qs8cbCqy2ylh7Vp5RllPjpn9Pi2F
 l5hcs+OnrQ8PIPHBfx08gNUrsQvFpiMBJqx33CbgGXhUHvJDwMnUy2yPFviYKxhqbd3E
 L8324neHoulfAiGj1v5O9aB626UDOVHBQmy0yDXUo7NulJsfut+qz6fuOvLw9Ml1Q6Cr
 rFEk6X9DuUGw2vOfYymjt7NjX+Suzk5nWaMoyri+3fl/uWbJqTG8eUEbg5KE+1Zk58ya +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33gc3p0cmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 11:59:16 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08BFhmgX086123;
        Fri, 11 Sep 2020 11:59:16 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33gc3p0cm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 11:59:15 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BFuno5016580;
        Fri, 11 Sep 2020 15:59:14 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 33dxdr4jjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 15:59:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08BFxBu17667972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 15:59:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 915C94C05E;
        Fri, 11 Sep 2020 15:59:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E33074C046;
        Fri, 11 Sep 2020 15:59:08 +0000 (GMT)
Received: from sig-9-65-251-51.ibm.com (unknown [9.65.251.51])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Sep 2020 15:59:08 +0000 (GMT)
Message-ID: <cb8b4ebaa35d79eba65b011d042d20a991adf540.camel@linux.ibm.com>
Subject: Re: [PATCH V2 2/3] integrity: Move import of MokListRT certs to a
 separate routine
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lenny Szubowicz <lszubowi@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, andy.shevchenko@gmail.com,
        James Morris <jmorris@namei.org>, serge@hallyn.com,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Jones <pjones@redhat.com>,
        David Howells <dhowells@redhat.com>, prarit@redhat.com
Date:   Fri, 11 Sep 2020 11:59:07 -0400
In-Reply-To: <f0a079b1-5f02-8618-fdfe-aea2278113c9@redhat.com>
References: <20200905013107.10457-1-lszubowi@redhat.com>
         <20200905013107.10457-3-lszubowi@redhat.com>
         <CAMj1kXEdkdeE8VSZqEzhd__Kb7_ZmG2af6iBpbY3=nsj1-phYw@mail.gmail.com>
         <f0a079b1-5f02-8618-fdfe-aea2278113c9@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_05:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=3 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110125
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2020-09-11 at 11:54 -0400, Lenny Szubowicz wrote:
> On 9/11/20 11:02 AM, Ard Biesheuvel wrote:
> > On Sat, 5 Sep 2020 at 04:31, Lenny Szubowicz <lszubowi@redhat.com> wrote:
> >>
> >> Move the loading of certs from the UEFI MokListRT into a separate
> >> routine to facilitate additional MokList functionality.
> >>
> >> There is no visible functional change as a result of this patch.
> >> Although the UEFI dbx certs are now loaded before the MokList certs,
> >> they are loaded onto different key rings. So the order of the keys
> >> on their respective key rings is the same.
> >>
> >> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
> > 
> > Why did you drop Mimi's reviewed-by from this patch?
> 
> It was not intentional. I was just not aware that I needed to propagate
> Mimi Zohar's reviewed-by from V1 of the patch to V2.
> 
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> 
> V2 includes changes in that patch to incorporate suggestions from
> Andy Shevchenko. My assumption was that the maintainer would
> gather up the reviewed-by and add any signed-off-by as appropriate,
> but it sounds like my assumption was incorrect. In retrospect, I
> could see that having the maintainer dig through prior versions
> of a patch set for prior reviewed-by tags could be burdensome.

As much as possible moving code should be done without making changes,
simpler for code review.   Then as a separate patch you make changes.  
That way you could also have retained my Reviewed-by.

Mimi

> 
> Advice on the expected handling of this would be appreciated.


