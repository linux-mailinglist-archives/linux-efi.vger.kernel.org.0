Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4704560D3
	for <lists+linux-efi@lfdr.de>; Thu, 18 Nov 2021 17:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbhKRQqY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Nov 2021 11:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbhKRQqU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Nov 2021 11:46:20 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C7FC06174A
        for <linux-efi@vger.kernel.org>; Thu, 18 Nov 2021 08:43:20 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id t26so28827374lfk.9
        for <linux-efi@vger.kernel.org>; Thu, 18 Nov 2021 08:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7D/BeXVr7wzzWFs8SKVTpLA5OK3s6ikrHABb23KOco=;
        b=CqP/wh5rSorV/TnAQxzdgsZz00pJ5cWLtZd6e3yhJ0X2NfcSIeOGNa4K1m8IOgAuZ/
         IhTPa0XJNMCiP+pgVih/Bi3fq+TwkhnPnoUretxdR/GVsXAbwudVYOECqRPhHYqKXLFQ
         IWNRqYT+ZOi+IcKyGcxDtm9HuylzUxlZ8WwILX5upefDxs8JGP6Q2BmfWBsc3yHywHAX
         9tg08Uy5hehL2b/S0KNhF2j1aITHPZTiUW1kXHrP4cuqQJJCU2ydhZs6+YN1zZ0LvLXR
         xNfmFuA0sXeU3wxMPjanG//zwdlWx6bTfDU1DGAk3gOII5FKYLJHJgajYOYiOX31wQsP
         LAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7D/BeXVr7wzzWFs8SKVTpLA5OK3s6ikrHABb23KOco=;
        b=GnnX3RjLwylClZ3COmZTSDDT29/bkdqdszNPHQ8zCvgpsFjpZRY9JKIPvgU+jFKez/
         aL/dOr/xYT7/v9XmjdWMkko2+F8Jh3F5CKk/S1FjNh6/YNEl8xHZUT75YpDzY8IU3PFO
         E7F8yIKIbp6RuAOLYVX2lHvhCkN5r33ZqnaN6VCJQxInjsEMx2BqqRp5momdH8BivOzQ
         3hr2kP6Syzl5Umx8NVW6BtuOe3s3TtwriVQEhyf/w33Vnvyf15dQMYunDiDRYLTodxvm
         fWxHs4jGRNaNClifdtfgxZBGTHMDbxJrq2kUFzZ3jesUYNWHvlZTVXxt+uSkMxNwaT6O
         alCw==
X-Gm-Message-State: AOAM533dGkUVH0+dPHXC9z7RrfJ8huI2mt9LwjADUITh9zuHskuZpTTs
        5K5kiW2nyRzNEzSP/7LNWskJR/iM8FvhX+uCwNAaqA==
X-Google-Smtp-Source: ABdhPJxW6myjWm6lja6OnE0jaItEXzM/1vqY0/QtkI9jvuFbZMxUM+NzZUA0oYBmrWBnvhOYOZf0hJ2GBlFtQttYCpA=
X-Received: by 2002:a05:6512:2804:: with SMTP id cf4mr1847789lfb.644.1637253797827;
 Thu, 18 Nov 2021 08:43:17 -0800 (PST)
MIME-Version: 1.0
References: <20211110220731.2396491-1-brijesh.singh@amd.com> <20211110220731.2396491-45-brijesh.singh@amd.com>
In-Reply-To: <20211110220731.2396491-45-brijesh.singh@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Thu, 18 Nov 2021 09:43:06 -0700
Message-ID: <CAMkAt6qGASUFv7_bEDd3zrwt2J8kRxKdNuZCGCnsNvnGr4Uv3g@mail.gmail.com>
Subject: Re: [PATCH v7 44/45] virt: sevguest: Add support to derive key
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 10, 2021 at 3:09 PM Brijesh Singh <brijesh.singh@amd.com> wrote:
>
> The SNP_GET_DERIVED_KEY ioctl interface can be used by the SNP guest to
> ask the firmware to provide a key derived from a root key. The derived
> key may be used by the guest for any purposes it choose, such as a
> sealing key or communicating with the external entities.
>
> See SEV-SNP firmware spec for more information.
>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  Documentation/virt/coco/sevguest.rst  | 19 ++++++++++-
>  drivers/virt/coco/sevguest/sevguest.c | 49 +++++++++++++++++++++++++++
>  include/uapi/linux/sev-guest.h        | 24 +++++++++++++
>  3 files changed, 91 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
> index 002c90946b8a..0bd9a65e0370 100644
> --- a/Documentation/virt/coco/sevguest.rst
> +++ b/Documentation/virt/coco/sevguest.rst
> @@ -64,10 +64,27 @@ The SNP_GET_REPORT ioctl can be used to query the attestation report from the
>  SEV-SNP firmware. The ioctl uses the SNP_GUEST_REQUEST (MSG_REPORT_REQ) command
>  provided by the SEV-SNP firmware to query the attestation report.
>
> -On success, the snp_report_resp.data will contains the report. The report
> +On success, the snp_report_resp.data will contain the report. The report
>  will contain the format described in the SEV-SNP specification. See the SEV-SNP
>  specification for further details.
>
> +2.2 SNP_GET_DERIVED_KEY
> +-----------------------
> +:Technology: sev-snp
> +:Type: guest ioctl
> +:Parameters (in): struct snp_derived_key_req
> +:Returns (out): struct snp_derived_key_req on success, -negative on error
> +
> +The SNP_GET_DERIVED_KEY ioctl can be used to get a key derive from a root key.

derived

> +The derived key can be used by the guest for any purpose, such as sealing keys
> +or communicating with external entities.
> +
> +The ioctl uses the SNP_GUEST_REQUEST (MSG_KEY_REQ) command provided by the
> +SEV-SNP firmware to derive the key. See SEV-SNP specification for further details
> +on the various fields passed in the key derivation request.
> +
> +On success, the snp_derived_key_resp.data will contains the derived key value. See
".data will contain the..." or ".data contains the derived key..."


> +the SEV-SNP specification for further details.
>
>  Reference
>  ---------
> diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
> index 982714c1b4ca..bece6856573e 100644
> --- a/drivers/virt/coco/sevguest/sevguest.c
> +++ b/drivers/virt/coco/sevguest/sevguest.c
> @@ -392,6 +392,52 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
>         return rc;
>  }
>
> +static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
> +{
> +       struct snp_guest_crypto *crypto = snp_dev->crypto;
> +       struct snp_derived_key_resp resp = {0};
> +       struct snp_derived_key_req req;
> +       int rc, resp_len;
> +       u8 buf[89];

Could we document this magic number?

> +
> +       if (!arg->req_data || !arg->resp_data)
> +               return -EINVAL;
> +
> +       /* Copy the request payload from userspace */
> +       if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
> +               return -EFAULT;
> +
> +       /* Message version must be non-zero */
> +       if (!req.msg_version)
> +               return -EINVAL;
> +
> +       /*
> +        * The intermediate response buffer is used while decrypting the
> +        * response payload. Make sure that it has enough space to cover the
> +        * authtag.
> +        */
> +       resp_len = sizeof(resp.data) + crypto->a_len;
> +       if (sizeof(buf) < resp_len)
> +               return -ENOMEM;
> +
> +       /* Issue the command to get the attestation report */
> +       rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, req.msg_version,
> +                                 SNP_MSG_KEY_REQ, &req.data, sizeof(req.data), buf, resp_len,
> +                                 &arg->fw_err);
> +       if (rc)
> +               goto e_free;

Should we check the first 32 bits of |data| here since that is a
status field? If we see 16h here we could return -EINVAL, or better to
let userspace deal with that error handling?

> +
> +       /* Copy the response payload to userspace */
> +       memcpy(resp.data, buf, sizeof(resp.data));
> +       if (copy_to_user((void __user *)arg->resp_data, &resp, sizeof(resp)))
> +               rc = -EFAULT;
> +
> +e_free:
> +       memzero_explicit(buf, sizeof(buf));
> +       memzero_explicit(&resp, sizeof(resp));
> +       return rc;
> +}
> +
>  static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
>  {
>         struct snp_guest_dev *snp_dev = to_snp_dev(file);
> @@ -417,6 +463,9 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>         case SNP_GET_REPORT:
>                 ret = get_report(snp_dev, &input);
>                 break;
> +       case SNP_GET_DERIVED_KEY:
> +               ret = get_derived_key(snp_dev, &input);
> +               break;
>         default:
>                 break;
>         }
> diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
> index eda7edcffda8..f6d9c136ff4d 100644
> --- a/include/uapi/linux/sev-guest.h
> +++ b/include/uapi/linux/sev-guest.h
> @@ -36,9 +36,33 @@ struct snp_guest_request_ioctl {
>         __u64 fw_err;
>  };
>
> +struct __snp_derived_key_req {
> +       __u32 root_key_select;
> +       __u32 rsvd;
> +       __u64 guest_field_select;
> +       __u32 vmpl;
> +       __u32 guest_svn;
> +       __u64 tcb_version;
> +};
> +
> +struct snp_derived_key_req {
> +       /* message version number (must be non-zero) */
> +       __u8 msg_version;
> +
> +       struct __snp_derived_key_req data;
> +};
> +
> +struct snp_derived_key_resp {
> +       /* response data, see SEV-SNP spec for the format */
> +       __u8 data[64];
> +};
> +
>  #define SNP_GUEST_REQ_IOC_TYPE 'S'
>
>  /* Get SNP attestation report */
>  #define SNP_GET_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x0, struct snp_guest_request_ioctl)
>
> +/* Get a derived key from the root */
> +#define SNP_GET_DERIVED_KEY _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x1, struct snp_guest_request_ioctl)
> +
>  #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
> --
> 2.25.1
>
