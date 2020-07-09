Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C9221A6A1
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jul 2020 20:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgGISJp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Jul 2020 14:09:45 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:43004 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726671AbgGISJp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Jul 2020 14:09:45 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 069I6M3L000380;
        Thu, 9 Jul 2020 18:09:16 GMT
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 325k3613r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 18:09:15 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 8EC4E7F;
        Thu,  9 Jul 2020 18:09:14 +0000 (UTC)
Received: from raspberrypi (unknown [16.214.51.10])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 0435C48;
        Thu,  9 Jul 2020 18:09:09 +0000 (UTC)
Date:   Thu, 9 Jul 2020 13:09:09 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     steve.wahl@hpe.com, Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oliver Neukum <oneukum@suse.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Young <dyoung@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Austin Kim <austindh.kim@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Russ Anderson <rja@hpe.com>
Subject: Re: [patch v2 09/13] x86: Remove efi=old_map command line option
Message-ID: <20200709180909.GO9832@raspberrypi>
References: <20200709145447.549145421@hpe.com>
 <20200709145448.652996700@hpe.com>
 <CALCETrXo9gTR0XWQ5e-YoRryyvJ3tuOaOVB+DyF5OUNRpfBteQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXo9gTR0XWQ5e-YoRryyvJ3tuOaOVB+DyF5OUNRpfBteQ@mail.gmail.com>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-09_09:2020-07-09,2020-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=1 mlxscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=881 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090126
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 09, 2020 at 09:02:01AM -0700, Andy Lutomirski wrote:
> On Thu, Jul 9, 2020 at 7:55 AM <steve.wahl@hpe.com> wrote:
> >
> > As a part of UV1 platform removal, delete the efi=old_map option,
> > which should no longer be needed.
> 
> Can you also update kernel_parameters.txt?
> 
> --Andy

I plan to, but (I mentioned in the intro email) kernel-parameters.txt
has pending changes in linux-next that conflict.  (The efi= option
values were alphabetized.)  So my plan is to issue a separate patch
if/when this gets accepted.  If you'd like me to take a different
aproach, let me know.

--> Steve

